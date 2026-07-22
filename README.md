# 🎡 Wheel of Fortune — Fancy Restaurant with Kuba

A wheel of fortune in the style of Slevomat's [kolotoč štěstí](https://www.slevomat.cz/kolotoc-stesti),
spinning up how an evening at a fancy restaurant *chosen by Kuba* will **really** turn out.

## 🎲 Possible outcomes

| Slice | What happens |
|-------|--------------|
| ⏰ **We wait 1.5h** | Reservation for 8 PM, food eventually. |
| 😋 **We leave hungry** | Portion like a postage stamp, bill like your rent. |
| 🪑 **No tables available** | "Do you have a reservation?" — "Yes." — "...and we don't." |
| 🤷 **They forget every other item** | You order 6 things, 3 arrive. |
| 🎰 **JACKPOT — all at once!** | All of the above, simultaneously. |

Each normal outcome appears on the wheel **2×**, while the **JACKPOT appears only 1×** — making it
the rarest (≈ 11% chance; the others ≈ 22% each).

## ▶️ Live demo

**https://mateuszkoslacz.com/kolko-fortuny-kuba/**

(`https://mkoslacz.github.io/kolko-fortuny-kuba/` also works — it redirects to the above)

## 🌴 Travelminit — Roata vacanțelor

There are two deliberately isolated Travelminit wheels:

- **Legacy fallback:** [`travelminit.html`](travelminit.html) stays unchanged and continues to
  read the existing legacy Google Sheet. Do not use it for a new campaign and do not point it at
  new data.
- **New campaign source:** [`travelminit-new.html`](travelminit-new.html) has no legacy Sheet
  URL. It is used only to create a new, immutable campaign release.

The generator copies only the new source:

```bash
bash scripts/create-travelminit-release.sh tm-YYYYMMDD-r01 '<published Version CSV URL>'
```

The full English Wix embedding and release procedure is in
[`docs/TRAVELMINIT-WIX-RELEASE-GUIDE.md`](docs/TRAVELMINIT-WIX-RELEASE-GUIDE.md).

## 🛠️ How it works

A single self-contained [`index.html`](index.html) — SVG + vanilla JavaScript, zero dependencies.
Hosted on GitHub Pages.

## 💻 Run locally

Just open `index.html` in a browser, or start a local server:

```bash
python3 -m http.server 4178
# then open http://localhost:4178
```

---

🤖 Generated with [Claude Code](https://claude.com/claude-code)
