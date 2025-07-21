#!/bin/bash
# Script simplificado para detectar e retornar o modo atual do monitor para waybar
# Depende apenas da saída do hyprctl para maior robustez.

# Garante que o hyprctl está disponível
if ! command -v hyprctl &> /dev/null; then
    echo "{\"text\": \"󰍸 ?\", \"tooltip\": \"Hyprland não está pronto\", \"class\": \"monitor-mode-error\"}"
    exit 1
fi

# Tenta obter a lista de monitores
MONITORS_JSON=$(hyprctl monitors -j 2>/dev/null)
if [ -z "$MONITORS_JSON" ]; then
    echo "{\"text\": \"󰍸 ?\", \"tooltip\": \"Falha ao detectar monitores\", \"class\": \"monitor-mode-error\"}"
    exit 1
fi

# Conta monitores internos (eDP) e externos (HDMI/DP)
INTERNAL_MONITOR=$(echo "$MONITORS_JSON" | jq 'map(select(.name | test("eDP"))) | length')
EXTERNAL_MONITOR=$(echo "$MONITORS_JSON" | jq 'map(select(.name | test("DP-|HDMI-"))) | length')

MODE="?"
TOOLTIP="Modo Desconhecido"
ICON="󰍸"

if [ "$INTERNAL_MONITOR" -gt 0 ] && [ "$EXTERNAL_MONITOR" -gt 0 ]; then
    MODE="D"
    TOOLTIP="Modo Dual Monitor"
    ICON="󰍺"
elif [ "$INTERNAL_MONITOR" -eq 0 ] && [ "$EXTERNAL_MONITOR" -gt 0 ]; then
    MODE="C"
    TOOLTIP="Modo Clamshell"
    ICON="󰍹"
elif [ "$INTERNAL_MONITOR" -gt 0 ] && [ "$EXTERNAL_MONITOR" -eq 0 ]; then
    MODE="S"
    TOOLTIP="Modo Single (Laptop)"
    ICON="󰌢"
fi

# Saída em formato JSON para waybar
echo "{\"text\": \"$ICON $MODE\", \"tooltip\": \"$TOOLTIP\", \"class\": \"monitor-mode-$MODE\"}"