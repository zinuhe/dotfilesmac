#!/bin/bash
# Tabs: Ctrl+PgDn = siguiente, Ctrl+PgUp = anterior, en Zed, VSCode, Obsidian e iTerm2.
# Zed ademas recibe su settings.json (incluye el color del tab activo).
# Uso: ./install.sh [ruta-del-vault-de-obsidian]   (default: ~/Documents/remote)
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
VAULT="${1:-$HOME/Documents/remote}"
STAMP="$(date +%Y%m%d-%H%M%S)"

link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then echo "ok       $dst"; return; fi
  if [ -L "$dst" ]; then rm "$dst"
  elif [ -e "$dst" ]; then mv "$dst" "$dst.bak-$STAMP"; echo "backup   $dst.bak-$STAMP"; fi
  ln -s "$src" "$dst"
  echo "enlazado $dst"
}

running() { pgrep -xq "$1"; }

# Zed y VSCode: el archivo completo vive en este repo y se enlaza
link "$DIR/zed-keymap.json" "$HOME/.config/zed/keymap.json"
link "$DIR/zed-settings.json" "$HOME/.config/zed/settings.json"
link "$DIR/vscode-keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"

# Obsidian: solo se parchean los dos hotkeys de tabs dentro del vault (conserva los demas)
HOTKEYS="$VAULT/.obsidian/hotkeys.json"
if [ ! -d "$VAULT/.obsidian" ]; then
  echo "saltado  Obsidian: no existe $VAULT/.obsidian (pasa la ruta del vault como argumento)"
elif running Obsidian; then
  echo "saltado  Obsidian esta abierto: cierralo y vuelve a correr este script"
else
  python3 - "$HOTKEYS" "$STAMP" <<'PY'
import json, os, shutil, sys
path, stamp = sys.argv[1], sys.argv[2]
exists = os.path.exists(path)
old = json.load(open(path)) if exists else {}
data = dict(old)
data["workspace:next-tab"] = [
    {"modifiers": ["Ctrl"], "key": "PageDown"},
    {"modifiers": ["Ctrl"], "key": "Tab"},
]
data["workspace:previous-tab"] = [
    {"modifiers": ["Ctrl"], "key": "PageUp"},
    {"modifiers": ["Ctrl", "Shift"], "key": "Tab"},
]
if exists and data == old:
    print("ok       " + path)
else:
    if exists:
        shutil.copy(path, path + ".bak-" + stamp)
    json.dump(data, open(path, "w"), indent=2)
    print("parcheado " + path)
PY
fi

# iTerm2: solo se parchean los dos atajos globales (Next Tab = accion 0, Previous Tab = accion 2)
PLIST="$HOME/Library/Preferences/com.googlecode.iterm2.plist"
if [ ! -f "$PLIST" ]; then
  echo "saltado  iTerm2: abrelo una vez para que cree sus preferencias y vuelve a correr"
elif running iTerm2; then
  echo "saltado  iTerm2 esta abierto: cierralo y vuelve a correr este script"
else
  RESULT="$(python3 - "$PLIST" "$STAMP" <<'PY'
import plistlib, shutil, sys
path, stamp = sys.argv[1], sys.argv[2]
with open(path, "rb") as f:
    prefs = plistlib.load(f)
km = prefs.setdefault("GlobalKeyMap", {})
changed = False
for key, action in (("0xf72d-0x40000-0x79", 0), ("0xf72c-0x40000-0x74", 2)):
    new = {"Version": 2, "Apply Mode": 0, "Action": action, "Text": "", "Escaping": 1}
    if km.get(key) != new:
        km[key] = new
        changed = True
if changed:
    shutil.copy(path, path + ".bak-" + stamp)
    with open(path, "wb") as f:
        plistlib.dump(prefs, f, fmt=plistlib.FMT_BINARY)
    print("parcheado iTerm2 (GlobalKeyMap)")
else:
    print("ok       iTerm2 (GlobalKeyMap)")
PY
)"
  echo "$RESULT"
  case "$RESULT" in parcheado*) killall cfprefsd 2>/dev/null || true ;; esac
fi
