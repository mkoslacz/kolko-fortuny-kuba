#!/usr/bin/env bash
set -euo pipefail

# Creates one immutable, deployable HTML address for a Travelminit campaign
# and prints the only iframe URL that should be pasted into Wix.

if [ "$#" -ne 2 ]; then
  printf 'Użycie: bash scripts/create-travelminit-release.sh <id-wydania> <adres-csv-manifestu>\n' >&2
  exit 64
fi

release_id="$1"
manifest_url="$2"

case "$release_id" in
  ''|*[!a-zA-Z0-9._-]*)
    printf 'Id wydania może zawierać tylko litery, cyfry, kropki, podkreślenia i myślniki.\n' >&2
    exit 64
    ;;
esac

case "$manifest_url" in
  https://*) ;;
  *)
    printf 'Adres manifestu musi zaczynać się od https://\n' >&2
    exit 64
    ;;
esac

encoded_manifest="$(python3 - "$manifest_url" <<'PY'
import sys
from urllib.parse import quote

print(quote(sys.argv[1], safe=""))
PY
)"

release_dir="releases/$release_id"
if [ -e "$release_dir" ]; then
  printf 'Wydanie już istnieje: %s\n' "$release_dir" >&2
  exit 1
fi

mkdir -p "$release_dir"
cp travelminit.html "$release_dir/travelminit.html"

release_url="https://mateuszkoslacz.com/kolko-fortuny-kuba/releases/$release_id/travelminit.html"

printf '\nGotowe wydanie: %s\n' "$release_dir/travelminit.html"
printf 'Po opublikowaniu tego pliku na GitHub Pages wklej do Wix wyłącznie:\n\n'
printf '<iframe src="%s?bare=1&manifest=%s" title="Roata vacanțelor Travelminit" style="display:block; width:100%%; border:0" loading="eager"></iframe>\n' "$release_url" "$encoded_manifest"
