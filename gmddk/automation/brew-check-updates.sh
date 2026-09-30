#!/bin/zsh
BREW=/opt/homebrew/bin/brew
UMBRAL=${UMBRAL:-5}

$BREW update --quiet >/dev/null 2>&1
PAQUETES=$($BREW outdated --greedy --quiet)
TOTAL=$(echo "$PAQUETES" | grep -c .)

echo "$(date '+%Y-%m-%d %H:%M') - $TOTAL actualizaciones"

if [ "$TOTAL" -gt "$UMBRAL" ]; then
  LISTA=$(echo "$PAQUETES" | head -5 | paste -sd, - | sed 's/,/, /g')
  osascript -e "display notification \"$LISTA...\" with title \"Homebrew: $TOTAL actualizaciones\" subtitle \"Corre: brew upgrade --greedy\" sound name \"Glass\""
fi
