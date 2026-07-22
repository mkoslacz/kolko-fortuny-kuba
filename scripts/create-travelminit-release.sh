#!/usr/bin/env bash
set -euo pipefail

# Creates one immutable, deployable HTML address for a Travelminit campaign
# and prints the exact Wix URL plus an iframe fallback.

if [ "$#" -ne 3 ]; then
  printf 'Usage: bash scripts/create-travelminit-release.sh <release-id> <prizes-csv-url> <texts-csv-url>\n' >&2
  exit 64
fi

release_id="$1"
prizes_url="$2"
texts_url="$3"

case "$release_id" in
  ''|*[!a-zA-Z0-9._-]*)
    printf 'Release ID may contain only letters, numbers, dots, underscores, and hyphens.\n' >&2
    exit 64
    ;;
esac

case "$prizes_url" in
  https://*) ;;
  *)
    printf 'Prizes URL must start with https://\n' >&2
    exit 64
    ;;
esac

case "$texts_url" in
  https://*) ;;
  *)
    printf 'Texts URL must start with https://\n' >&2
    exit 64
    ;;
esac

release_dir="releases/$release_id"
if [ -e "$release_dir" ]; then
  printf 'Release already exists: %s\n' "$release_dir" >&2
  exit 1
fi

mkdir -p "$release_dir"
cp travelminit-new.html "$release_dir/travelminit.html"

python3 - "$release_dir/travelminit.html" "$prizes_url" "$texts_url" <<'PY'
import json
import sys
from pathlib import Path

release_file = Path(sys.argv[1])
prizes_url = sys.argv[2]
texts_url = sys.argv[3]
source = release_file.read_text(encoding="utf-8")
replacements = {
    'prizesUrl: ""': 'prizesUrl: ' + json.dumps(prizes_url),
    'textsUrl: ""': 'textsUrl: ' + json.dumps(texts_url),
}

for needle, replacement in replacements.items():
    if source.count(needle) != 1:
        raise SystemExit("Could not inject the live Sheet URL into the release source.")
    source = source.replace(needle, replacement, 1)

release_file.write_text(
    source,
    encoding="utf-8",
)
PY

release_url="https://mateuszkoslacz.com/kolko-fortuny-kuba/releases/$release_id/travelminit.html"

printf '\nRelease created: %s\n' "$release_dir/travelminit.html"
printf 'In Wix, use “Embed a Site” and paste this exact URL:\n\n'
printf '%s?bare=1\n\n' "$release_url"
printf 'If Wix requires HTML iframe code, use only:\n\n'
printf '<iframe src="%s?bare=1" title="Roata vacanțelor Travelminit" style="display:block; width:100%%; border:0" loading="eager"></iframe>\n' "$release_url"
