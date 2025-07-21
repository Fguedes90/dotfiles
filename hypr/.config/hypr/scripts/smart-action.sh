#!/bin/bash
# Smart Action - Executa ações contextuais baseadas na aplicação ativa

ACTION=$1

if [ -z "$ACTION" ]; then
    echo "Uso: $0 <save|find|open|close>"
    exit 1
fi

# Detectar aplicação ativa
WINDOW_INFO=$(hyprctl activewindow -j 2>/dev/null)

if [ -z "$WINDOW_INFO" ] || [ "$WINDOW_INFO" = "null" ]; then
    # Nenhuma janela ativa
    case "$ACTION" in
        "save")
            # Screenshot como fallback
            grimblast --notify save area ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
            ;;
        "find")
            # Abrir launcher
            wofi --show drun
            ;;
        *)
            notify-send "Smart Action" "Nenhuma janela ativa"
            ;;
    esac
    exit 0
fi

# Extrair informações da janela
APP_CLASS=$(echo "$WINDOW_INFO" | jq -r '.class // "unknown"' | tr '[:upper:]' '[:lower:]')
APP_TITLE=$(echo "$WINDOW_INFO" | jq -r '.title // "Unknown"')

# Debug (comentar em produção)
# notify-send "Smart Action Debug" "App: $APP_CLASS\nAction: $ACTION"

# Executar ação baseada no contexto
case "$ACTION" in
    "save")
        case "$APP_CLASS" in
            code|"code-oss"|vscodium)
                # VS Code - Salvar arquivo
                wtype -M ctrl -P s -m ctrl
                ;;
            vim|nvim|emacs|helix)
                # Editores no terminal - comando save
                wtype -P Escape
                sleep 0.1
                wtype ":w" -P Return
                ;;
            chromium|"chromium-browser"|chrome|firefox|brave)
                # Browser - Salvar página
                wtype -M ctrl -P s -m ctrl
                ;;
            libreoffice*|onlyoffice*)
                # Office - Salvar documento
                wtype -M ctrl -P s -m ctrl
                ;;
            gimp|inkscape|krita)
                # Editores gráficos
                wtype -M ctrl -P s -m ctrl
                ;;
            *)
                # Fallback - Screenshot
                grimblast --notify save area ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
                notify-send "📸 Screenshot" "Salvo em ~/Pictures/Screenshots/"
                ;;
        esac
        ;;
        
    "find")
        case "$APP_CLASS" in
            code|"code-oss"|vscodium|vim|nvim|emacs|helix)
                # Editores - Buscar no arquivo
                wtype -M ctrl -P f -m ctrl
                ;;
            chromium|"chromium-browser"|chrome|firefox|brave)
                # Browser - Buscar na página
                wtype -M ctrl -P f -m ctrl
                ;;
            "org.gnome.nautilus"|nautilus|thunar|dolphin|nemo)
                # File managers - Buscar arquivos
                wtype -M ctrl -P f -m ctrl
                ;;
            "com.mitchellh.ghostty"|ghostty|kitty|alacritty)
                # Terminal - Buscar no histórico
                wtype -M ctrl -P r -m ctrl
                ;;
            obsidian)
                # Obsidian - Command palette
                wtype -M ctrl -P p -m ctrl
                ;;
            *)
                # Fallback - Tentar Ctrl+F genérico
                wtype -M ctrl -P f -m ctrl
                ;;
        esac
        ;;
        
    "open")
        case "$APP_CLASS" in
            code|"code-oss"|vscodium)
                # VS Code - Quick open
                wtype -M ctrl -P p -m ctrl
                ;;
            vim|nvim)
                # Vim - Open file
                wtype -P Escape
                sleep 0.1
                wtype ":e "
                ;;
            chromium|"chromium-browser"|chrome|firefox|brave)
                # Browser - Open URL
                wtype -M ctrl -P l -m ctrl
                ;;
            "org.gnome.nautilus"|nautilus|thunar|dolphin)
                # File manager - Open location
                wtype -M ctrl -P l -m ctrl
                ;;
            obsidian)
                # Obsidian - Quick switcher
                wtype -M ctrl -P o -m ctrl
                ;;
            *)
                # Fallback - Tentar Ctrl+O genérico
                wtype -M ctrl -P o -m ctrl
                ;;
        esac
        ;;
        
    "close")
        case "$APP_CLASS" in
            code|"code-oss"|vscodium)
                # VS Code - Fechar editor atual
                wtype -M ctrl -P w -m ctrl
                ;;
            chromium|"chromium-browser"|chrome|firefox|brave)
                # Browser - Fechar aba
                wtype -M ctrl -P w -m ctrl
                ;;
            *)
                # Fallback - Fechar janela
                hyprctl dispatch killactive
                ;;
        esac
        ;;
        
    "help")
        # Mostrar ajuda contextual
        /home/francis/.config/hypr/scripts/keybindings/contextual-help.sh
        ;;
        
    *)
        notify-send "Smart Action" "Ação desconhecida: $ACTION"
        exit 1
        ;;
esac