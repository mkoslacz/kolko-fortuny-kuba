# Travelminit Wheel — Live Google Sheet and Wix Guide

## 1. Two independent wheels

### Legacy fallback — keep its URL and Sheet

The existing fallback remains at:

`https://mateuszkoslacz.com/kolko-fortuny-kuba/travelminit.html`

It keeps using the existing legacy Google Sheet and is the emergency fallback. Do not point it at
the new campaign Sheet or replace its URL in Wix unless rolling back deliberately.

### New campaign wheel

The new campaign uses the same proven live-Sheet mechanism as legacy, but with a different Google
Sheet and a different immutable release URL, for example:

`https://mateuszkoslacz.com/kolko-fortuny-kuba/releases/tm-20260722-r01/travelminit.html?bare=1`

The Wix URL remains unchanged for the whole campaign. After first setup, campaign changes happen
only in Google Sheets: no new Wix publish, no new HTML release, and no manual CSV re-publish.

## 2. One-time Google Sheet setup

Create one **new** Google Sheet for this campaign. Do not copy, rename, edit, or connect the legacy
Sheet. The new Sheet contains only public campaign copy and offers; do not put personal or sensitive
data in it.

Create exactly two tabs, with these English names:

### `Prizes`

First row:

```text
type,icon,label,title,description,coupon,url
```

Add one row per wheel segment. Use `prize`, `coupon`, or `tryagain` as `type`.

- `prize`: use `icon`, `label`, `title`, `description`, and `url`; leave `coupon` empty.
- `coupon`: use all fields, including `coupon` and `url`.
- `tryagain`: use `type`, `icon`, and `label`; the other fields may be empty.

### `Texts`

First row:

```text
key,value
```

Use these keys, each with a non-empty value:

```text
topline
headline
body1
body2
body3
spinButton
hub
ctaPrize
ctaCoupon
tryAgainTitle
tryAgainDesc
```

Tab names, headers, and keys stay in English. The visible campaign copy may be Romanian.

## 3. Publish the two tabs once

For **each** tab (`Prizes` and `Texts`):

1. Open **File → Share → Publish to web**.
2. Select the individual tab, not the full spreadsheet.
3. Select **Comma-separated values (.csv)**.
4. Click **Publish** and copy the URL.
5. In **Published content and settings**, make sure **Automatically republish when changes are
   made** stays enabled.

Send the two published CSV URLs to Engineering once. Do not create a `Version` tab, snapshot tabs,
or a new CSV URL for ordinary campaign edits.

Google automatically republishes Sheet edits; Google says this can take a few minutes. The wheel
uses a cache-busted CSV request on load, when the visible tab regains focus, and every 60 seconds
while it is visible and idle. More importantly, each spin makes its own fresh request for `Prizes`
immediately before selecting a segment. It waits up to 3.5 seconds; if no valid live prize list is
available, it does not draw and tells the visitor to retry. A slow or unavailable `Texts` tab never
blocks the prize check.

This prevents an old browser session from drawing from its in-memory prize list. It is not an
atomic stock-reservation system: Google publication can still take time, and two visitors can read
the same last available row at the same time. A strict per-prize limit needs a server-side claim
endpoint before the spin starts.

## 4. Initial engineering release

Engineering creates one immutable release from the two URLs:

```bash
bash scripts/create-travelminit-release.sh tm-20260722-r01 '<published Prizes CSV URL>' '<published Texts CSV URL>'
git add releases/tm-20260722-r01/travelminit.html
git commit -m 'feat: release Travelminit campaign tm-20260722-r01'
git push origin main
```

After the exact public URL returns HTTP 200, Engineering sends this URL to Wix:

`https://mateuszkoslacz.com/kolko-fortuny-kuba/releases/tm-20260722-r01/travelminit.html?bare=1`

## 5. Embed in Wix — once

Use **Embed a Site**, not copied static HTML.

1. Open the campaign page in Wix.
2. Choose **Add Elements → Embed Code → Embed a Site**.
3. Choose **Enter Website Address** and paste the final release URL from Engineering.
4. Remove or disable every old or duplicate wheel element on this page.
5. Publish Wix.
6. In **Pages & Menu → More Actions → Settings → Advanced Settings**, enable manual page-cache
   control and select **Never (disable caching)**. Publish Wix again.
7. In Wix Mobile Editor, confirm that the one remaining embed is enabled, fully visible, and not
   clipped.

## 6. Every ordinary campaign change

Edit only the cells in `Prizes` or `Texts`.

If one campaign change affects both tabs, complete both edits in one short session and verify the
live wheel after a few minutes. This keeps the short Google auto-republish window from showing a
new prize list with old copy, or the reverse.

Do **not**:

- publish CSV again;
- create a new Sheet tab;
- change the Wix URL;
- rebuild or redeploy the wheel.

Open the live release URL with `?bare=1&debug=1` after a few minutes to check that the new content
has arrived. The Wix URL itself stays unchanged.

## 7. Code or layout change

Only a code or layout change needs a new HTML release and a Wix URL swap:

1. Keep the current release available for rollback.
2. Create a new release using the same two CSV URLs.
3. Test its direct URL on desktop and mobile.
4. Replace the Wix embed URL only after the test passes, then publish Wix.

## 8. Rollback

For a campaign-content rollback, restore the prior values in `Prizes` or `Texts` (Google Sheets
version history is suitable). For a code rollback, switch Wix back to the previous immutable release
URL. The independent legacy fallback is always available at:

`https://mateuszkoslacz.com/kolko-fortuny-kuba/travelminit.html`
