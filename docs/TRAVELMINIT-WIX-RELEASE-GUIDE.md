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

Engineering creates this URL after receiving the public CSV URL of the `Wersja` sheet tab and
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

1. Prepare three working tabs: `Premii`, `Texte`, and `Wersja`.
2. Review the campaign content in `Premii` and `Texte`.
3. Create a new numeric revision, for example `20260722001`.
4. Duplicate the working tabs as `Premii-20260722001` and `Texte-20260722001`.
5. Publish both snapshot tabs to the web as CSV files.
6. Open both CSV URLs in a browser and verify their contents.
7. Put exactly one active row into `Wersja` with these columns:
   `revision`, `premii_url`, `texte_url`, and `published_at`.
8. Publish the `Wersja` tab as CSV and send its public CSV URL to Engineering.
9. Engineering creates and publishes the immutable wheel release, then returns the final Wix URL.
10. Paste that URL into Wix following section 2.

Never edit a published snapshot tab after it has been referenced by `Wersja`.

## 4. Publishing a content change during a live campaign

A content update does not require a Wix change, a new iframe URL, or a new HTML release.

1. Update the working `Premii` and `Texte` tabs.
2. Create a new, higher numeric revision.
3. Duplicate both tabs into new snapshot tabs named with that revision.
4. Publish both new snapshot tabs as CSV.
5. Verify both CSV URLs.
6. Replace the one active row in `Wersja` in one paste operation.
7. Do not edit individual manifest cells one by one.
8. Verify the live wheel using the release URL with `&debug=1`.

The live wheel loads prizes and texts as one complete version. It never mixes an old `Premii`
snapshot with a new `Texte` snapshot.

## 5. Releasing a code or layout change

Create a new release only when the wheel HTML, behaviour, or visual design changes.

1. Keep the currently live release unchanged.
2. Create a new release ID, for example `tm-20260722-r02`.
3. Build and publish the new release.
4. Test the direct release URL with `&debug=1`.
5. Verify it in Wix Preview on desktop and mobile.
6. Replace the Wix embed URL only after the new release passes verification.
7. Publish Wix.
8. Keep the previous release available for rollback.

A code release changes the Wix URL once. A data-only release changes only `Wersja`.

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

1. Open the direct new release URL with `&debug=1`.
2. Confirm that the displayed revision and publication time match `Wersja`.
3. Open the real Wix campaign URL, including its UTM parameters.
4. Test on desktop and mobile.
5. Confirm that there is exactly one wheel on the page.
6. Open the legacy URL separately and confirm that it still shows the old legacy wheel.
