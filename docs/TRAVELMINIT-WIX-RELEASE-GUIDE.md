# Travelminit Wheel — Wix Embedding and Release Guide

## 1. Two independent wheels

### Legacy fallback — do not change

The existing wheel remains available at:

`https://mateuszkoslacz.com/kolko-fortuny-kuba/travelminit.html`

It uses the existing legacy Google Sheet. It must not be edited, replaced, or pointed at the new
campaign data. Use this URL only as an emergency fallback if a new campaign release is not ready.

Do not add a `manifest` parameter to the legacy URL. Do not reuse the legacy URL for a new
campaign.

### New campaign wheel

Each new campaign receives its own immutable release URL, for example:

`https://mateuszkoslacz.com/kolko-fortuny-kuba/releases/tm-20260722-r01/travelminit.html?bare=1`

Engineering creates this URL after receiving the public CSV URL of the `Version` sheet tab and
stores that URL inside the immutable release. Do not assemble or edit the URL manually. The Google
Sheet itself is never embedded in Wix; Wix receives only the final wheel URL.

## 2. Embed the new wheel in Wix

Use **Embed a Site**, not copied static HTML.

1. Open the campaign page in Wix.
2. Select **Add Elements** → **Embed Code** → **Embed a Site**.
3. Select the embed and choose **Enter Website Address**.
4. Paste the exact final release URL supplied by Engineering.
5. Set the element to the full available page width and make its height large enough to show the
   full wheel, spin button, and result card on both desktop and mobile.
6. Remove or disable every older wheel element on this page: old HTML embeds, copied static HTML,
   duplicate mobile embeds, and previous iframe URLs.
7. Publish the Wix site.

For this campaign page, disable Wix page caching:

1. Open **Pages & Menu**.
2. Click **More Actions** next to the campaign page.
3. Open **Settings** → **Advanced Settings**.
4. Enable manual page-cache control.
5. Select **Never (disable caching)**.
6. Publish again.

There must be exactly one wheel on the page.

## 3. First release of a new campaign

The new wheel uses a Google Sheets manifest and immutable data snapshots.

1. Create a completely new Google Sheet for this campaign. Do not copy, rename, or edit the
   legacy campaign Sheet.
2. Create exactly three working tabs, using these English names: `Prizes`, `Texts`, and `Version`.
3. Use this exact header row in `Prizes`:
   `type,icon,label,title,description,coupon,url`.
   Add one row for every wheel segment. `type` must be `prize`, `coupon`, or `tryagain`.
4. Use this exact header row in `Texts`: `key,value`. Keep every required key:
   `topline`, `headline`, `body1`, `body2`, `body3`, `spinButton`, `hub`, `ctaPrize`,
   `ctaCoupon`, `tryAgainTitle`, and `tryAgainDesc`.
5. Review the campaign content in `Prizes` and `Texts`, then choose a new numeric revision, for
   example `20260722001`.
6. Duplicate the approved working tabs as `Prizes-20260722001` and `Texts-20260722001`.
7. Publish **each snapshot tab individually** as CSV:
   **File → Share → Publish to web → Link → select that tab → Comma-separated values (.csv) →
   Publish**. Copy the generated URL for each tab.
8. Open both published CSV URLs in a private browser window and verify their contents.
9. Put exactly one active row into `Version`, using this exact header row:
   `revision,prizes_url,texts_url,published_at`.
   The one data row must contain the numeric revision and the two snapshot CSV URLs.
10. Publish the `Version` tab as CSV through the same path. Send its **published CSV URL** (not a
    Google Sheets `/edit` URL) to Engineering.
11. Engineering creates and publishes the immutable wheel release:

    ```bash
    bash scripts/create-travelminit-release.sh tm-20260722-r01 '<published Version CSV URL>'
    git add releases/tm-20260722-r01/travelminit.html
    git commit -m 'feat: release Travelminit campaign tm-20260722-r01'
    git push origin main
    ```

12. Engineering waits until the exact public release URL returns HTTP 200, then returns that final
    Wix URL.
13. Paste that URL into Wix following section 2.

Never edit a published snapshot tab after it has been referenced by `Version`.

## 4. Publishing a content change during a live campaign

A content update does not require a Wix change, a new iframe URL, or a new HTML release.

1. Update the working `Prizes` and `Texts` tabs.
2. Create a new, higher numeric revision.
3. Duplicate both tabs into new snapshot tabs named with that revision.
4. Publish both new snapshot tabs as CSV.
5. Verify both CSV URLs.
6. Replace the one active row in `Version` in one paste operation.
7. Do not edit individual manifest cells one by one.
8. Verify the live wheel using the release URL with `?bare=1&debug=1`.

The live wheel loads prizes and texts as one complete version. It never mixes an old `Prizes`
snapshot with a new `Texts` snapshot.

## 5. Releasing a code or layout change

Create a new release only when the wheel HTML, behaviour, or visual design changes.

1. Keep the currently live release unchanged.
2. Create a new release ID, for example `tm-20260722-r02`.
3. Run:

   ```bash
   bash scripts/create-travelminit-release.sh tm-20260722-r02 '<published Version CSV URL>'
   ```

4. Commit and push the generated `releases/tm-20260722-r02/travelminit.html` file:

   ```bash
   git add releases/tm-20260722-r02/travelminit.html
   git commit -m 'feat: release Travelminit campaign tm-20260722-r02'
   git push origin main
   ```

5. Wait until the exact public release URL returns HTTP 200, then test it with
   `?bare=1&debug=1`.
6. Verify it in Wix Preview on desktop and mobile.
7. Replace the Wix embed URL only after the new release passes verification.
8. Publish Wix.
9. Keep the previous release available for rollback.

A code release changes the Wix URL once. A data-only release changes only `Version`.

## 6. Rollback

### Roll back campaign content

Create a new, higher manifest revision that points to the previously known-good pair of immutable
snapshot CSV files. Do not decrease the revision number and do not edit an old snapshot.

### Roll back wheel code

Replace the Wix embed URL with the previous known-good release URL and publish Wix.

The legacy wheel remains independently available at:

`https://mateuszkoslacz.com/kolko-fortuny-kuba/travelminit.html`

## 7. Final release check

Before sending campaign traffic:

1. Open the direct new release URL with `?bare=1&debug=1`.
2. Confirm that the displayed revision and publication time match `Version`.
3. Open the real Wix campaign URL, including its UTM parameters.
4. Test on desktop and mobile.
5. In Wix Mobile Editor, confirm that the embed is enabled, fully visible, and not clipped.
6. Confirm that there is exactly one wheel on the page.
7. Open the legacy URL separately and confirm that it still shows the old legacy wheel.
