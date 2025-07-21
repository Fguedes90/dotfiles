#!/bin/bash
# Script para navegação limitada a 5 workspaces

get_current_workspace() {
    hyprctl activewindow -j | jq -r '.workspace.id' 2>/dev/null || echo "1"
}

navigate_workspace() {
    local direction="$1"
    local current=$(get_current_workspace)
    local new_workspace=$current
    
    case "$direction" in
        "next")
            new_workspace=$((current + 1))
            # Limitar ao máximo de 5
            if [ $new_workspace -gt 5 ]; then
                new_workspace=1  # Volta para o primeiro
            fi
            ;;
        "prev")
            new_workspace=$((current - 1))
            # Limitar ao mínimo de 1
            if [ $new_workspace -lt 1 ]; then
                new_workspace=5  # Vai para o último
            fi
            ;;
        *)
            # Se for um número direto, validar
            if [[ "$direction" =~ ^[0-9]+$ ]]; then
                if [ "$direction" -le 5 ] && [ "$direction" -ge 1 ]; then
                    new_workspace=$direction
                else
                    # Se for maior que 5, ficar no 5
                    new_workspace=5
                fi
            fi
            ;;
    esac
    
    hyprctl dispatch workspace $new_workspace
}

# Executar navegação
navigate_workspace "$1"
