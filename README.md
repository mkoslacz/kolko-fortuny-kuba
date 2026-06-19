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

### Editing the prizes (no code needed)

Open the `?edit` URL, change the texts and the 10 slots (each prize has its own link), click
**"Aplică pe roată"** to preview, then **"Copiază linkul"**. The whole configuration is encoded in
that link's `#cfg=…` hash — just paste the link on the static page. No files to edit, works on any
host. Daily routine: edit → copy link → update the link on the page.

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
