# 🚨 PILNE - Wykonaj Deployment Teraz!

## ⚠️ Problem

**Kod Snake jest gotowy i zmergowany do `main` branch, ALE aplikacja na Fly.io NIE została zaktualizowana!**

To dlatego nadal nie widzisz Snake - używasz starej wersji aplikacji.

---

## ✅ Rozwiązanie - WYKONAJ DEPLOYMENT

Musisz wdrożyć nowy kod na serwer Fly.io. Masz 2 opcje:

---

### Opcja 1: Deployment przez GitHub Actions (automatyczny - raz skonfiguruj, potem działa zawsze)

**KROK 1:** Dodaj secret do GitHub

1. Otwórz: https://github.com/michalkopec1981/Saper-Fly/settings/secrets/actions
2. Kliknij "New repository secret"
3. Name: `FLY_API_TOKEN`
4. Value: [Twój token z Fly.io - zobacz niżej jak go zdobyć]
5. Kliknij "Add secret"

**JAK ZDOBYĆ TOKEN:**

Otwórz terminal na swoim komputerze i uruchom:
```bash
flyctl auth token
```

Lub przez stronę Fly.io:
- https://fly.io/dashboard → Account Settings → Tokens → Create Token

**KROK 2:** Uruchom workflow

Po dodaniu secretu, idź do:
- https://github.com/michalkopec1981/Saper-Fly/actions
- Znajdź "Deploy to Fly.io"
- Kliknij "Run workflow" → "Run workflow"

**LUB** po prostu zrób jakikolwiek push do `main` - deployment uruchomi się automatycznie!

---

### Opcja 2: Deployment Ręczny (szybszy - POLECAM TERAZ)

**To jest najprostsza i najszybsza opcja aby zobaczyć Snake od razu!**

Na swoim komputerze, w terminalu:

```bash
# 1. Przejdź do folderu projektu
cd /ścieżka/do/Saper-Fly

# 2. Upewnij się że masz najnowszy kod
git checkout main
git pull origin main

# 3. Zaloguj się do Fly.io (jeśli nie jesteś zalogowany)
flyctl auth login

# 4. WYKONAJ DEPLOYMENT (to wdroży kod na serwer)
flyctl deploy
```

**To wszystko!** 🎉

Deployment zajmie 2-3 minuty. Potem odśwież stronę i Snake będzie widoczny!

---

## 🔍 Jak sprawdzić czy działa:

Po deploymencie:

1. **Odśwież przeglądarkę** (Ctrl+Shift+R lub Cmd+Shift+R)
2. **Otwórz panel Host** → zakładka **Minigry**
3. **Powinieneś zobaczyć:**
   - 🎮 Tetris
   - 🏓 Arkanoid
   - 🐍 **Snake** ← TERAZ WIDOCZNY!

**LUB sprawdź w konsoli przeglądarki (F12):**
```javascript
document.getElementById('snake-toggle')
// Powinno zwrócić element zamiast null
```

---

## 📊 Potwierdzenie

Kod Snake jest gotowy w repozytorium:
- ✅ Commit: `1c5fd12 Add Snake minigame to game collection`
- ✅ Zmergowany do `main` przez PR #2
- ✅ Plik `templates/host.html` zawiera sekcję Snake
- ✅ Plik `static/snake.js` istnieje
- ✅ API `/api/host/minigames/status` zwraca `snake_enabled`

**Jedyne czego brakuje:** Wdrożenie na serwer Fly.io!

---

## ⚡ TL;DR - Co robić TERAZ:

**Najszybsze rozwiązanie:**

```bash
cd /ścieżka/do/Saper-Fly
git checkout main
git pull origin main
flyctl deploy
```

Po 2-3 minutach Snake będzie widoczny! 🐍

---

*Jeśli masz problemy z którimkolwiek krokiem, daj znać!*
