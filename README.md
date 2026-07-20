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

Wersja Travelminit ma 10 pól, rumuńskie teksty i trzy typy wyników: nagrodę z linkiem,
kupon z kodem oraz „spróbuj ponownie”.

### Nowa kampania = nowy, niezmienny adres wydania

Nie podmieniaj istniejącego `travelminit.html` tuż przed kampanią. Dla każdej kampanii
tworzymy nowy fizyczny adres wydania; dzięki temu urządzenie, które było w poprzedniej
kampanii, nie może użyć swojego starego pliku HTML.

Gdy `Wersja` zawiera już pierwszy kompletny snapshot i jest opublikowana jako CSV, uruchom
w katalogu projektu:

```bash
bash scripts/create-travelminit-release.sh tm-20260720-r01 'https://docs.google.com/spreadsheets/d/e/.../pub?gid=...&single=true&output=csv'
```

Skrypt tworzy `releases/tm-20260720-r01/travelminit.html` i wypisuje gotowy iframe z
zakodowanym adresem manifestu. Dodaj nowy katalog do repozytorium i opublikuj go na GitHub
Pages, a następnie **dokładnie ten wypisany iframe** wklej do Wix. Będzie miał postać:

```html
<iframe src="https://mateuszkoslacz.com/kolko-fortuny-kuba/releases/tm-20260720-r01/travelminit.html?bare=1&manifest=ZAKODOWANY_ADRES_WERSJA_CSV"
  title="Roata vacanțelor Travelminit"
  style="display:block; width:100%; border:0"
  loading="eager"></iframe>
```

Od startu kampanii adres iframe i plik wydania pozostają niezmienne. Zmieniasz wyłącznie
manifest `Wersja` według procedury niżej — bez edycji HTML-a, bez zmiany Wix i bez nowego URL-a
w newsletterze.

### Jedno źródło koła na Wix

Na stronie kampanii osadzaj **tylko jeden iframe** wskazujący na publiczny adres powyżej. Nie
zostawiaj równolegle statycznego HTML w Wix ani drugiego elementu dla widoku mobilnego — wtedy
część osób może dostać inną, starszą wersję.

Na stronie `roata-vacantelor` wyłącz cache strony:

1. W Wix wejdź w **Pages & Menu**.
2. Przy stronie kampanii kliknij **More Actions** → **Settings** → **Advanced Settings**.
3. Włącz **Manually control caching for this page**.
4. Przy **How often do you want to reset this page’s cache?** wybierz **Never (disable caching)**.
5. Kliknij **Publish**. Samo zapisanie zmian nie aktualizuje strony produkcyjnej.

### Atomowa publikacja treści — bez kodu

Nie edytuj opublikowanych danych `Premii` i `Texte` w miejscu. Samo ustawienie wersji na końcu
nie byłoby atomowe: użytkownik mógłby pobrać nowe premie i stare teksty albo odwrotnie.

Zaimportuj do Google Sheeta dwa pliki robocze oraz manifest:

- [`travelminit-sheet-Premii.csv`](travelminit-sheet-Premii.csv) → robocza zakładka `Premii`;
- [`travelminit-sheet-Texte.csv`](travelminit-sheet-Texte.csv) → robocza zakładka `Texte`;
- [`travelminit-sheet-Version.csv`](travelminit-sheet-Version.csv) → zakładka `Wersja`.

Zakładkę `Wersja` opublikuj raz jako CSV (`File` → `Share` → `Publish to web` →
`Comma-separated values (.csv)`). Jej stały adres podajesz skryptowi przy tworzeniu wydania;
skrypt umieszcza go w adresie iframe jako parametr `manifest`.

`Wersja` jest manifestem z dokładnie jednym aktywnym wierszem:

- `revision` — nowy, rosnący identyfikator publikacji, np. `20260720002`;
- `premii_url` — adres CSV **niezmiennego snapshotu** premii dla tej rewizji;
- `texte_url` — adres CSV **niezmiennego snapshotu** tekstów dla tej rewizji;
- `published_at` — czas przełączenia w ISO UTC, np. `2026-07-20T12:30:00Z`.

Kolejność publikacji jest obowiązkowa:

1. Zmień i sprawdź robocze `Premii` oraz `Texte`.
2. Nadaj nową rewizję, np. `20260720002`, i zduplikuj obie zakładki jako
   `Premii-20260720002` oraz `Texte-20260720002`.
3. Opublikuj **obie duplikaty** przez `File` → `Share` → `Publish to web` →
   `Comma-separated values (.csv)`; skopiuj ich dwa adresy CSV i sprawdź je w przeglądarce.
4. Nigdy nie zmieniaj już opublikowanych snapshotów. Poprawka zawsze oznacza nową rewizję i nowe
   duplikaty zakładek.
5. **Dopiero na końcu** przygotuj pełny nowy wiersz manifestu i wklej go jedną operacją do
   `Wersja`: `revision`, oba adresy snapshotów oraz `published_at`. Nie poprawiaj tych komórek
   pojedynczo. Ten zapis przełącza komplet premii i tekstów.

Nie używaj publicznie `?edit` ani linków z `#cfg=…`: omijają manifest i mogą utrwalić
indywidualną, nieaktualną konfigurację.

### Kontrola przed publikacją

Po zmianie otwórz adres koła z `?debug=1` (jeżeli adres iframe ma już parametr, dodaj
`&debug=1`). Sprawdź, czy pokazane `revision` i `published_at` są identyczne z manifestem
`Wersja`, a następnie sprawdź zwykły publiczny adres bez parametru. Test wykonaj również na tym
samym linku kampanijnym z UTM-ami, który był użyty w newsletterze.

Linki ofert są przyjmowane wyłącznie w formacie `http(s)`; układ jest dostosowany do telefonu.

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
