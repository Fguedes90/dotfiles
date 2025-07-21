#!/bin/bash
# Script para detectar e retornar o modo atual do monitor para waybar

# Detectar estado do lid
LID_STATE="open"
if [ -f "/proc/acpi/button/lid/LID/state" ]; then
    if grep -q "closed" "/proc/acpi/button/lid/LID/state"; then
        LID_STATE="closed"
    fi
fi

# Detectar monitores ativos
MONITORS=$(hyprctl monitors -j 2>/dev/null | jq -r '.[].name' 2>/dev/null | sort)
MONITOR_COUNT=$(echo "$MONITORS" | wc -l)

# Determinar modo baseado nos monitores ativos
if echo "$MONITORS" | grep -q "eDP-1" && echo "$MONITORS" | grep -qE "(DP-|HDMI-)"; then
    # Ambos monitores ativos = Dual
    MODE="D"
    TOOLTIP="Dual Monitor Mode"
elif echo "$MONITORS" | grep -qE "(DP-|HDMI-)" && ! echo "$MONITORS" | grep -q "eDP-1"; then
    # Apenas monitor externo = Clamshell
    MODE="C"
    TOOLTIP="Clamshell Mode"
elif echo "$MONITORS" | grep -q "eDP-1" && [ "$MONITOR_COUNT" -eq 1 ]; then
    # Apenas monitor interno = Single
    MODE="S"
    TOOLTIP="Single Monitor Mode"
else
    # Fallback
    MODE="?"
    TOOLTIP="Unknown Mode"
fi

# Verificar arquivo de estado como fallback
if [ "$MODE" = "?" ] && [ -f "/tmp/current-monitor-mode" ]; then
    STATE=$(cat /tmp/current-monitor-mode 2>/dev/null)
    case "$STATE" in
        "single") MODE="S"; TOOLTIP="Single Monitor Mode" ;;
        "dual") MODE="D"; TOOLTIP="Dual Monitor Mode" ;;
        "clamshell") MODE="C"; TOOLTIP="Clamshell Mode" ;;
    esac
fi

# Adicionar ícone baseado no modo
case "$MODE" in
    "S") ICON="󰌢" ;;  # Laptop
    "D") ICON="󰍺" ;;  # Dual monitor
    "C") ICON="󰍹" ;;  # Monitor externo
    *) ICON="󰍸" ;;   # Unknown
esac

# Saída em formato JSON para waybar
echo "{\"text\": \"$ICON $MODE\", \"tooltip\": \"$TOOLTIP\", \"class\": \"monitor-mode-$MODE\"}"