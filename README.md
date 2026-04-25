# Caelestia Shell (Enhanced Fork)

This is a fork of the Caelestia Shell for Quickshell with built-in Emoji and Clipboard modes.

## New Features
- **Emoji Picker**: Search and copy emojis/kaomojis instantly using `>emoji `.
- **Clipboard History**: Search and copy your clipboard history using `>clip `.
- **Integrated UI**: Grid and list views directly in the launcher.

## Installation

1. **Clone the repository**:
   ```bash
   mv ~/.config/quickshell/caelestia ~/.config/quickshell/caelestia.bak
   git clone https://github.com/dylanmccune/caelestia-shell.git ~/.config/quickshell/caelestia
   ```

2. **Add actions to `~/.config/caelestia/shell.json`**:
   Insert these into the `launcher.actions` array:
   ```json
   {
     "command": ["autocomplete", "clip"],
     "description": "Search and copy clipboard history",
     "enabled": true,
     "icon": "history",
     "name": "Clipboard"
   },
   {
     "command": ["autocomplete", "emoji"],
     "description": "Search and copy emojis",
     "enabled": true,
     "icon": "emoji_emotions",
     "name": "Emoji"
   }
   ```

3. **Configure Hyprland keybinds**:
   Add these to `~/.config/hypr/hyprland/keybinds.conf` (or replace relevant lines):
   ```conf
   bind = Super, V, global, caelestia:clipboard
   bind = Super, BackSpace, global, caelestia:clearClipboard
   bind = Super, Period, global, caelestia:emoji
   ```

4. **Reload Shell**:
   ```bash
   qs -c caelestia
   ```

## Requirements
- `cliphist` (for clipboard history)
- `wl-copy` (for copying)
