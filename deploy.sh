#!/bin/bash

# Skrypt do deploymentu aplikacji Saper-Fly na Fly.io
# 🚀 Wykonaj ten skrypt aby wdrożyć Snake na produkcję!

set -e  # Zatrzymaj na błędzie

echo "=============================================="
echo "🚀 DEPLOYMENT SAPER-FLY NA FLY.IO"
echo "=============================================="
echo ""

# Sprawdź czy jesteśmy w repozytorium
if [ ! -d ".git" ]; then
    echo "❌ Błąd: Nie jesteś w folderze repozytorium!"
    echo "   Przejdź do folderu Saper-Fly i uruchom ponownie."
    exit 1
fi

# Sprawdź czy flyctl jest zainstalowany
if ! command -v flyctl &> /dev/null; then
    echo "❌ flyctl nie jest zainstalowany!"
    echo ""
    echo "Zainstaluj flyctl:"
    echo "  macOS/Linux: curl -L https://fly.io/install.sh | sh"
    echo "  Windows: https://fly.io/docs/hands-on/install-flyctl/"
    echo ""
    exit 1
fi

echo "✅ flyctl znaleziony: $(flyctl version)"
echo ""

# Sprawdź czy jesteś zalogowany
if ! flyctl auth whoami &> /dev/null; then
    echo "❌ Nie jesteś zalogowany do Fly.io"
    echo "   Loguję..."
    flyctl auth login
    echo ""
fi

echo "✅ Zalogowany do Fly.io: $(flyctl auth whoami)"
echo ""

# Pobierz najnowszy kod
echo "📥 Pobieranie najnowszego kodu z GitHub..."
git fetch origin
CURRENT_BRANCH=$(git branch --show-current)
echo "   Obecny branch: $CURRENT_BRANCH"

if [ "$CURRENT_BRANCH" != "main" ]; then
    echo "   Przełączam na branch main..."
    git checkout main
fi

git pull origin main
echo "✅ Kod zaktualizowany"
echo ""

# Sprawdź czy Snake jest w kodzie
if grep -q "snake-toggle" templates/host.html; then
    echo "✅ Snake znaleziony w kodzie (snake-toggle w host.html)"
else
    echo "⚠️  UWAGA: Nie znaleziono snake-toggle w kodzie!"
    echo "   Czy na pewno masz najnowszą wersję?"
fi
echo ""

# Wykonaj deployment
echo "🚀 Rozpoczynam deployment na Fly.io..."
echo "   (To może zająć 2-3 minuty)"
echo ""

flyctl deploy --remote-only

echo ""
echo "=============================================="
echo "✅ DEPLOYMENT ZAKOŃCZONY POMYŚLNIE!"
echo "=============================================="
echo ""
echo "🎉 Snake powinien być teraz widoczny w panelu Host!"
echo ""
echo "Sprawdź:"
echo "  1. Odśwież przeglądarkę (Ctrl+Shift+R lub Cmd+Shift+R)"
echo "  2. Otwórz panel Host → zakładka Minigry"
echo "  3. Powinieneś zobaczyć: Tetris, Arkanoid i 🐍 Snake"
echo ""
echo "Aplikacja: https://saper-qr.fly.dev"
echo ""
