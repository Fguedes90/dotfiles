#!/bin/bash
# Script para detectar a aplicação ativa e mostrar no Waybar

# Detectar janela ativa
window_info=$(hyprctl activewindow -j 2>/dev/null)

if [ -z "$window_info" ] || [ "$window_info" = "null" ]; then
    echo '{"text": "Desktop", "class": "desktop", "tooltip": "No active window"}'
    exit 0
fi

# Extrair informações
app_class=$(echo "$window_info" | jq -r '.class // "unknown"' | tr '[:upper:]' '[:lower:]')
app_title=$(echo "$window_info" | jq -r '.title // ""' | cut -c1-50)

# Mapear ícones
case "$app_class" in
    "chromium"|"chromium-browser")
        icon="🌐"
        name="Chromium"
        ;;
    "com.mitchellh.ghostty"|"ghostty")
        icon="👻"
        name="Ghostty"
        ;;
    "org.gnome.nautilus"|"nautilus")
        icon="📁"
        name="Nautilus"
        ;;
    "claude"|"claude-desktop")
        icon="🤖"
        name="Claude"
        ;;
    "obsidian")
        icon="🗒️"
        name="Obsidian"
        ;;
    "btop"|"btop++")
        icon="📊"
        name="btop"
        ;;
    "lazydocker")
        icon="🐳"
        name="LazyDocker"
        ;;
    "code"|"code-oss"|"vscodium")
        icon="💻"
        name="VS Code"
        ;;
    *)
        icon="📱"
        name=$(echo "$app_class" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1')
        ;;
esac

# Output JSON para Waybar
echo "{\"text\": \"$icon $name\", \"class\": \"$app_class\", \"tooltip\": \"$app_title\\nPress Super+F1 for keybindings\"}"