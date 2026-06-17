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
