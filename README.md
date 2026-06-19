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

## 🌴 Second version — Travelminit (Roata vacanțelor)

A rebranded variant for the Travelminit guerilla campaign *"Travelminit, du-mă oriunde cu 9 RON"*:
brand colors (orange `#f8980d` / purple `#71246b` / white), Romanian copy, a **10-slot** wheel,
unlimited spins, and confetti on a win. Three slot types (color-coded):

- 🟠 **Big prize** — links to the offer (e.g. a 9 RON stay); CTA *"Rezervă acum"*.
- 🟣 **Coupon** — shows a **copyable discount code** + link; CTA *"Folosește cuponul"*.
- ⚪ **Try again** — no link.

- **Public wheel:** https://mateuszkoslacz.com/kolko-fortuny-kuba/travelminit.html
- **Prize editor:** https://mateuszkoslacz.com/kolko-fortuny-kuba/travelminit.html?edit

### Editing the prizes (no code)

Two ways:

1. **Google Sheet (recommended for daily updates):** point the wheel at a published Google Sheet
   (set `prizesUrl` / `textsUrl` near the top of `travelminit.html`). The wheel reads it **live**, so
   editing the sheet updates the wheel — nothing else to touch, banner/embed link stays fixed.
   Templates: [`travelminit-sheet-Premii.csv`](travelminit-sheet-Premii.csv) (prizes) and
   [`travelminit-sheet-Texte.csv`](travelminit-sheet-Texte.csv) (texts) — import each into a tab named
   `Premii` / `Texte`, then File → Share → Publish to web → CSV.
2. **Built-in editor (`?edit`):** edit in a form, **"Aplică pe roată"** to preview, **"Copiază linkul"** —
   the whole config is encoded in the link's `#cfg=…` hash. Good for a one-off or preview without a sheet.

Offer links are sanitized to `http(s)` only; the layout is mobile-optimized.

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
