# Travelminit V2 — weighted prize probabilities

## Wix URL

Use this fixed address in Wix (**Embed a Site**):

```text
https://mateuszkoslacz.com/kolko-fortuny-kuba/travelminitv2.html
```

Do not add query parameters or configuration to this URL. V2 reads the same fixed
`Premii`, `Texte`, and `Status` tabs as legacy `travelminit.html`.

## Add one column in `Premii`

Append this exact eighth header to the existing first row:

```text
probabilitate
```

Every visible wheel row, including `tryagain`, needs a value. All values together
must total **100% ±0.1 percentage point**.

Recommended format: write percentage points explicitly, for example `70%`, `20%`,
and `10%`. V2 also accepts `70`, `20`, `10`, and decimal fractions such as `0.2`
for `20%`.

Example:

```text
tip,icon,eticheta,titlu,descriere,cod,link,probabilitate
cupon,🎟️,60 RON,Reducere 60 RON,...,,,70%
cupon,🎟️,30 RON,Reducere 30 RON,...,,,20%
tryagain,🔄,Mai încearcă,,,,,10%
```

The visible wheel slices remain equal in size. The new column controls only the
chance that each slice is selected.

## Safety behaviour

If the column is missing, any value is empty or invalid, or the total is not
100% ±0.1, V2 automatically uses equal chances for all visible wheel segments.
It does not show an error to a visitor or block the wheel. It writes one detailed
error to the browser console for that invalid Sheet snapshot.

The old `travelminit.html` ignores the added column, so adding it is safe before
switching Wix to V2.

Every spin still performs its existing fresh `Status` + `Premii` read immediately
before selection, so a probability edit from the Sheet applies to the next spin
without republishing Wix.
