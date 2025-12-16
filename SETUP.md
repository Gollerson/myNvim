# Neovim Configuration Setup

Diese Anleitung zeigt dir, wie du diese Neovim-Konfiguration auf einem neuen PC installierst.

## Voraussetzungen

- Neovim >= 0.9.0
- Git
- ripgrep (für Telescope)
- fd (optional, für bessere Performance)
- Node.js (für LSP-Server)
- Python 3 mit pip (für Python-Plugins)
- Ein Nerd Font (für Icons)

## Installation auf einem neuen PC

### 1. Backup der alten Konfiguration (falls vorhanden)

```bash
# Backup der alten Neovim-Konfiguration
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.local/state/nvim ~/.local/state/nvim.backup
mv ~/.cache/nvim ~/.cache/nvim.backup
```

### 2. Konfiguration klonen

```bash
# Klone dieses Repository nach ~/.config/nvim
git clone <DEIN-GIT-REPO-URL> ~/.config/nvim
```

### 3. Neovim starten

```bash
nvim
```

Beim ersten Start wird LazyVim automatisch alle Plugins installieren. Das kann ein paar Minuten dauern.

### 4. Mason LSP-Server installieren

Nach der Plugin-Installation öffne Mason:

```vim
:Mason
```

Die wichtigsten LSP-Server werden automatisch installiert. Du kannst weitere manuell hinzufügen.

## Änderungen synchronisieren

### Änderungen committen

```bash
cd ~/.config/nvim
git add -A
git commit -m "Beschreibung deiner Änderungen"
git push
```

### Änderungen auf anderen PCs übernehmen

```bash
cd ~/.config/nvim
git pull
```

Danach Neovim neu starten, damit die Änderungen wirksam werden.

## Remote Repository hinzufügen

Wenn du das Repository auf GitHub/GitLab hochladen möchtest:

```bash
cd ~/.config/nvim
git remote add origin <DEIN-GIT-REPO-URL>
git branch -M main
git push -u origin main
```

## Wichtige Dateien

- `init.lua` - Einstiegspunkt der Konfiguration
- `lua/config/` - LazyVim Konfiguration (options, keymaps, autocmds)
- `lua/plugins/` - Custom Plugin-Konfigurationen
- `lazy-lock.json` - Plugin-Versionen (sollte committed werden für Reproduzierbarkeit)

## Tipps

- Die `lazy-lock.json` wird committed, um sicherzustellen, dass alle PCs die gleichen Plugin-Versionen verwenden
- Bei Problemen: Lösche `~/.local/share/nvim` und starte Neovim neu
- Führe regelmäßig `:Lazy sync` aus, um Plugins zu aktualisieren
