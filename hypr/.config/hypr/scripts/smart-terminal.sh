#!/bin/bash
# Smart Terminal - Abre terminal ou cria split se já estiver em um terminal

# Detectar aplicação ativa
ACTIVE_WINDOW=$(hyprctl activewindow -j 2>/dev/null)

if [ -z "$ACTIVE_WINDOW" ] || [ "$ACTIVE_WINDOW" = "null" ]; then
    # Nenhuma janela ativa - abrir novo terminal
    ghostty
    exit 0
fi

# Extrair classe da aplicação
APP_CLASS=$(echo "$ACTIVE_WINDOW" | jq -r '.class // "unknown"' | tr '[:upper:]' '[:lower:]')

# Verificar se é um terminal conhecido
case "$APP_CLASS" in
    "com.mitchellh.ghostty"|"ghostty")
        # Já em Ghostty - enviar comando de split
        # Ghostty usa Ctrl+Shift+Enter para split horizontal
        wtype -M ctrl -M shift -P Return -m shift -m ctrl
        ;;
    "kitty")
        # Kitty usa Ctrl+Shift+Enter para split
        wtype -M ctrl -M shift -P Return -m shift -m ctrl
        ;;
    "alacritty"|"wezterm"|"foot")
        # Estes terminais geralmente não suportam splits nativos
        # Abrir novo terminal ao lado
        ghostty &
        sleep 0.2
        # Mover para a direita da janela atual
        hyprctl dispatch movewindow r
        ;;
    *)
        # Não é um terminal - abrir novo
        ghostty
        ;;
esac