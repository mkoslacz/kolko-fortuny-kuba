# Travelminit Wheel — Google Sheets and Wix Release Guide

## 1. Two independent wheels

### Legacy fallback — keep its URL and Sheet

The existing fallback remains at:

`https://mateuszkoslacz.com/kolko-fortuny-kuba/travelminit.html`

It continues to use the existing legacy Google Sheet. Do not connect the new campaign Sheet to it
or replace its Wix URL unless rolling back deliberately.

### New campaign wheel

Create a separate immutable release for each new campaign, for example:

`https://mateuszkoslacz.com/kolko-fortuny-kuba/releases/tm-20260722-r01/travelminit.html?bare=1`

Wix embeds this address once. From then on, normal campaign operations happen only in Google
Sheets: prize changes, copy changes, and the `0 → 1` launch switch do not require a Wix publish,
a new HTML release, or Google Sheets "Publish to web".

## 2. One-time Google Sheet setup

Create one **new** Google Sheet for the campaign. Do not copy, rename, edit, or connect the
legacy Sheet. Keep the Sheet limited to public campaign copy and offers; never put personal or
sensitive data in it.

Keep any existing `Version` tab untouched; it is ignored by this direct-CSV release. Create these
three tabs with the exact English names below.

### `Prizes`

First row:

```text
type,icon,label,title,description,coupon,url
```

Add one row per wheel segment. Use `prize`, `coupon`, or `tryagain` as `type`.

- `prize`: use `icon`, `label`, `title`, `description`, and `url`; leave `coupon` empty.
- `coupon`: use all fields, including `coupon` and `url`.
- `tryagain`: use `type`, `icon`, and `label`; the other fields may be empty.

The supplied legacy CSV template uses Romanian equivalents (`tip`, `eticheta`, `titlu`,
`descriere`, `cod`, `link`, and `cupon`). The wheel accepts both forms; for a new Sheet, prefer
the English header shown above.

### `Texts`

First row:

```text
key,value
```

These live-wheel keys need a non-empty value:

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

The supplied legacy CSV template uses `cheie,valoare`; those Romanian header names are accepted
too. For a new Sheet, prefer `key,value`.

These optional keys control the Romanian pre-launch screen:

```text
preLiveTopline
preLiveHeadline
preLiveBody
preLiveSpinButton
preLiveHub
```

If the optional keys are empty, the wheel uses safe Romanian defaults, including
`Loteria nu a început încă` and `Rămâi aproape — revenim în curând!`.

### `Status`

First row and only data value:

```text
status
0
```

`0` means **not live**. It shows a non-interactive mock wheel and the Romanian pre-launch copy;
no prize labels or spin control are exposed. Change only cell `A2` from `0` to `1` when the
campaign is live. Changing it back to `0` safely closes the wheel again.

Tab names, headers, and keys stay in English. Visible campaign copy may be Romanian.

## 3. Make the three tabs readable once — do not use “Publish to web”

1. In the Sheet, choose **Share**.
2. Under **General access**, select **Anyone with the link** and role **Viewer**.
3. Open each individual tab (`Prizes`, `Texts`, `Status`) and copy its `gid` from the browser URL.
4. Form a direct CSV URL for each tab:

```text
https://docs.google.com/spreadsheets/d/<SHEET_ID>/export?format=csv&gid=<TAB_GID>
```

Send the three direct CSV URLs to Engineering once.

Before sending them, open each direct CSV URL in an incognito/private browser window. It must show
CSV without a Google sign-in prompt. For `Status`, confirm the complete content is exactly
`status` on the first line and `0` on the second. A missing permission or wrong URL deliberately
keeps the wheel in the safe pre-launch state.

The direct-export URL reads the current Sheet cells. Every wheel request also has a cache-buster,
so this path does not depend on Google’s “Publish to web” auto-republish delay. The wheel checks
the visible tab on focus and at least every 60 seconds while it is open and idle. Each spin makes
its own fresh `Status` + `Prizes` request immediately before choosing a segment, with a 3.5-second
deadline. If either safety-critical read is not valid, it does not draw. `Texts` is deliberately a
separate, non-blocking request: it updates the page copy on a later refresh, but never holds up a
spin or weakens the prize/status check.

This is not an atomic stock-reservation system: two visitors can still read the same last available
row at the same time. A strict per-prize inventory limit requires a server-side claim endpoint
before the spin starts.

## 4. Initial engineering release

Engineering creates one immutable release from the three direct CSV URLs:

```bash
bash scripts/create-travelminit-release.sh tm-20260722-r01 \
  '<Prizes direct CSV URL>' \
  '<Texts direct CSV URL>' \
  '<Status direct CSV URL>'
git add releases/tm-20260722-r01/travelminit.html
git commit -m 'feat: release Travelminit campaign tm-20260722-r01'
git push origin main
```

The fourth argument is optional only for an older campaign that deliberately has no launch gate.
For a new campaign, always provide the `Status` URL and leave `A2` as `0` until launch.

After the exact public URL returns HTTP 200, Engineering sends this address to Wix:

`https://mateuszkoslacz.com/kolko-fortuny-kuba/releases/tm-20260722-r01/travelminit.html?bare=1`

## 5. Embed in Wix — once

Use **Embed a Site**, not copied static HTML.

1. Open the campaign page in Wix.
2. Choose **Add Elements → Embed Code → Embed a Site**.
3. Choose **Enter Website Address** and paste the final release URL from Engineering.
4. Remove or disable every old or duplicate wheel element on this page.
5. Publish Wix.
6. In Wix Mobile Editor, confirm that the one remaining embed is enabled, fully visible, and not
   clipped.

The `Status = 0` screen is intentionally safe to publish in Wix days before launch. No second Wix
publication is needed when `Status` becomes `1`.

## 6. Every ordinary campaign change

Edit only cells in `Prizes`, `Texts`, or `Status`.

- Change `Status!A2` from `0` to `1` to launch; change it to `0` to close safely.
- Edit `Prizes` to change available outcomes.
- Edit `Texts` to change live or pre-launch copy.

Do **not**:

- use **Publish to web** or manually republish CSV;
- create a new CSV URL for an ordinary change;
- change the Wix URL;
- rebuild or redeploy the wheel.

Open the live release URL with `?bare=1&debug=1` after a change to verify it. A copy change may
appear on the next focus or 60-second active-tab refresh once the wheel is idle (not spinning and
without a visible result), but it never blocks a spin.

## 7. Code or layout change

Only a code or layout change needs a new HTML release and a Wix URL swap:

1. Keep the current release available for rollback.
2. Create a new release with a new unique ID (for example, `tm-20260722-r02`) using the same
   three direct CSV URLs.
3. Test its direct URL on desktop and mobile.
4. Replace the Wix embed URL only after the test passes, then publish Wix.

## 8. Rollback

For campaign content, restore prior Sheet cells using Google Sheets version history. For a code
rollback, switch Wix back to the previous immutable release URL. The independent legacy fallback
is always available at:

`https://mateuszkoslacz.com/kolko-fortuny-kuba/travelminit.html`
