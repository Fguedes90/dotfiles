#!/bin/bash
# Lid Switch Handler FINAL + BACKLIGHT - ROG Flow X13
# Controla tela + backlight do teclado automaticamente

CLAMSHELL_SCRIPT="$HOME/.config/hypr/scripts/display/clamshell.sh"
LOG_FILE="/tmp/lid-switch-backlight-rog.log"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Verificar se o script final existe
if [ ! -f "$CLAMSHELL_SCRIPT" ]; then
    log_message "ERRO: Script clamshell final não encontrado: $CLAMSHELL_SCRIPT"
    # Usar script temporário como fallback
    CLAMSHELL_SCRIPT="/tmp/clamshell-final-backlight-rog.sh"
    if [ ! -f "$CLAMSHELL_SCRIPT" ]; then
        log_message "ERRO: Nenhum script clamshell encontrado"
        exit 1
    fi
fi

# Verificar se Hyprland está rodando
if ! pgrep -x "Hyprland" > /dev/null; then
    log_message "AVISO: Hyprland não está rodando"
    exit 0
fi

# ROG Flow X13 - Arquivo específico do lid
LID_STATE_FILE="/proc/acpi/button/lid/LID/state"

log_message "=== LID SWITCH EVENT + BACKLIGHT DETECTADO ==="

if [ -f "$LID_STATE_FILE" ]; then
    lid_state=$(cat "$LID_STATE_FILE")
    log_message "Estado do lid: $lid_state"
    
    if echo "$lid_state" | grep -q "closed"; then
        log_message "🔒 LID FECHADO - Ativando clamshell mode + desligando backlight teclado"
        # Aguardar estabilização
        sleep 1
        # Executar modo clamshell que FUNCIONA + controle backlight
        "$CLAMSHELL_SCRIPT" auto
        log_message "✅ Comando clamshell + backlight OFF executado"
        
    elif echo "$lid_state" | grep -q "open"; then
        log_message "🔓 LID ABERTO - Ativando modo dual + ligando backlight teclado LOW"
        # Executar modo dual + backlight low
        "$CLAMSHELL_SCRIPT" auto
        log_message "✅ Comando dual monitor + backlight LOW executado"
    fi
else
    log_message "ERRO: Arquivo de lid não encontrado: $LID_STATE_FILE"
    # Fallback - executar detecção automática
    "$CLAMSHELL_SCRIPT" auto
fi

log_message "=== LID SWITCH + BACKLIGHT PROCESSADO ==="
