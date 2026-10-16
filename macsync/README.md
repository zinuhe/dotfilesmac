# dotfiles

Configuración personal de Mac, sincronizada entre máquinas con git.

## Tabs: `Ctrl + PgDn` / `Ctrl + PgUp`

Mismo atajo para cambiar de tab en Zed, VSCode, Obsidian e iTerm2:

| Acción | Atajo |
|---|---|
| Tab siguiente | `Ctrl + PgDn` |
| Tab anterior | `Ctrl + PgUp` |

En un MacBook sin teclas `PgUp` y `PgDn`, se escriben como `Ctrl + Fn + ↓` y `Ctrl + Fn + ↑`.

### Archivos

| Archivo | Para qué sirve |
|---|---|
| `tabs/install.sh` | Aplica la configuración en la Mac donde se corre |
| `tabs/zed-keymap.json` | Keymap de Zed |
| `tabs/zed-settings.json` | Settings de Zed (fuentes, minimap, tema y color del tab activo) |
| `tabs/vscode-keybindings.json` | Atajos de VSCode (incluye `Cmd+1/2/3`) |

### Cómo se aplica a cada app

| App | Método | Destino |
|---|---|---|
| Zed (keymap) | Enlace simbólico al archivo completo | `~/.config/zed/keymap.json` |
| Zed (settings) | Enlace simbólico al archivo completo | `~/.config/zed/settings.json` |
| VSCode | Enlace simbólico al archivo completo | `~/Library/Application Support/Code/User/keybindings.json` |
| Obsidian | Parche de solo los dos hotkeys de tabs | `<vault>/.obsidian/hotkeys.json` |
| iTerm2 | Parche de solo los dos atajos globales | `~/Library/Preferences/com.googlecode.iterm2.plist` (`GlobalKeyMap`) |

- **Zed y VSCode:** un cambio en un Mac llega al otro con `git pull`, porque ambos leen el archivo del repo.
- **Obsidian e iTerm2:** el script no reemplaza el archivo, solo cambia los atajos de tabs y respeta el resto de la configuración. Obsidian guarda sus atajos dentro de cada vault, por eso se pasa la ruta del vault.
- **Respaldos:** antes de cambiar un archivo, el script guarda una copia `.bak-fecha` al lado.

### Instalar en una Mac nueva

1. Cierra Obsidian e iTerm2. Si están abiertos, el script los salta y avisa.
2. Clona y corre el script:

```bash
git clone <URL-del-repo> ~/dotfiles && ~/dotfiles/tabs/install.sh
```

Si el vault de Obsidian no está en `~/Documents/remote`, pasa la ruta como argumento:

```bash
~/dotfiles/tabs/install.sh /ruta/al/vault
```

El script se puede correr varias veces sin problema.

### Subir cambios al repo

```bash
cd ~/dotfiles && git add . && git commit -m "Descripción del cambio" && git push
```

En la otra Mac:

```bash
cd ~/dotfiles && git pull
```

### Detalles técnicos

- **Zed:** el keymap usa el contexto `Workspace || Pane || Editor || Terminal`. Con solo `Workspace` o `Pane` el atajo no funcionaba, porque el `base_keymap` VSCode que tiene activo asigna esa combinación en el contexto `Editor`, que tiene prioridad.
- **Obsidian:** además de `Ctrl+PgDn/PgUp`, conserva `Ctrl+Tab` y `Ctrl+Shift+Tab`. Antes de este repo los atajos estaban invertidos (`Ctrl+PgUp` iba hacia adelante).
- **iTerm2:** `Next Tab` es la acción `0` y `Previous Tab` es la acción `2` en `GlobalKeyMap`. Las claves son `0xf72d-0x40000-0x79` (`Ctrl+PgDn`) y `0xf72c-0x40000-0x74` (`Ctrl+PgUp`).

### Color del tab activo en Zed

`zed-settings.json` define el fondo del tab activo con `theme_overrides`, para el tema One Dark:

```json
"theme_overrides": {
  "One Dark": {
    "tab.active_background": "#2f5d9e"
  }
}
```

- Para cambiar el color, edita el valor `#2f5d9e`.
- El override aplica solo al tema indicado. Si cambias de tema, copia el bloque con el nombre del nuevo tema.
- Otras claves útiles en el mismo bloque: `tab.inactive_background` (tabs inactivos) y `tab_bar.background` (toda la barra de tabs).
- Como el archivo completo se sincroniza, en la otra Mac también se aplican las demás opciones de `settings.json` (fuentes, minimap, tema). El script guarda una copia `.bak-fecha` del archivo anterior.

### Depuración en Zed

Si un atajo no responde, abre el command palette (`Cmd + Shift + P`) y ejecuta:

- **`zed: open keymap`**: abre el editor de atajos y permite grabar qué tecla recibe Zed.
- **`dev: open key context view`**: muestra qué atajo se disparó y en qué contexto.
