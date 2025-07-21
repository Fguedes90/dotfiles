#!/bin/bash
# SOLUÇÃO MELHORADA - ROG Flow X13 - COM VERIFICAÇÕES DE ESTADO
# Substitui delays fixos por verificações dinâmicas

LOG_FILE="/tmp/clamshell-final-rog.log"
INTERNAL_MONITOR="eDP-1"
MAX_RETRIES=10
RETRY_DELAY=0.1

# Detectar monitor externo dinamicamente
detect_external_monitor() {
    # Verificar HDMI primeiro
    if [ -f "/sys/class/drm/card1-HDMI-A-1/status" ] && [ "$(cat /sys/class/drm/card1-HDMI-A-1/status)" = "connected" ]; then
        echo "HDMI-A-1"
        return
    fi
    
    # Verificar DP-8 (LG ULTRAWIDE)
    if [ -f "/sys/class/drm/card1-DP-8/status" ] && [ "$(cat /sys/class/drm/card1-DP-8/status)" = "connected" ]; then
        echo "DP-8"
        return
    fi
    
    # Verificar outros DPs
    for dp in DP-1 DP-2 DP-3 DP-4 DP-5 DP-6 DP-7; do
        if [ -f "/sys/class/drm/card1-$dp/status" ] && [ "$(cat /sys/class/drm/card1-$dp/status)" = "connected" ]; then
            echo "$dp"
            return
        fi
    done
    
    echo "none"
}

EXTERNAL_MONITOR=$(detect_external_monitor)

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Função para aguardar monitor estar pronto
wait_for_monitor() {
    local monitor="$1"
    local expected_state="$2"
    local retries=0
    
    log_message "⏳ Aguardando monitor $monitor estar $expected_state..."
    
    while [ $retries -lt $MAX_RETRIES ]; do
        if [ "$expected_state" = "active" ]; then
            if hyprctl monitors | grep -q "Monitor $monitor"; then
                log_message "✅ Monitor $monitor ativo"
                return 0
            fi
        elif [ "$expected_state" = "disabled" ]; then
            if ! hyprctl monitors | grep -q "Monitor $monitor" || hyprctl monitors | grep -A2 "Monitor $monitor" | grep -q "disabled: true"; then
                log_message "✅ Monitor $monitor desabilitado"
                return 0
            fi
        fi
        
        sleep $RETRY_DELAY
        ((retries++))
    done
    
    log_message "⚠️ Timeout aguardando monitor $monitor estar $expected_state"
    return 1
}

# Função para verificar se comando hyprctl foi aplicado
verify_hyprctl_command() {
    local command="$1"
    local verify_function="$2"
    local retries=0
    
    # Executar comando
    hyprctl $command
    
    # Verificar se foi aplicado
    while [ $retries -lt $MAX_RETRIES ]; do
        if $verify_function; then
            return 0
        fi
        sleep $RETRY_DELAY
        ((retries++))
    done
    
    log_message "⚠️ Comando não foi aplicado completamente: $command"
    return 1
}

# Função para controlar backlight do teclado
control_keyboard_backlight() {
    local action="$1"
    
    if command -v asusctl &> /dev/null; then
        case "$action" in
            "off")
                log_message "🔦 Desligando backlight do teclado..."
                asusctl -k off
                log_message "✅ Backlight do teclado: OFF"
                ;;
            "low")
                log_message "🔦 Ligando backlight do teclado no mínimo..."
                asusctl -k low
                log_message "✅ Backlight do teclado: LOW"
                ;;
            "status")
                if asusctl -k 2>/dev/null | grep -q "Off"; then
                    echo "off"
                else
                    echo "on"
                fi
                ;;
        esac
    else
        log_message "⚠️  asusctl não disponível - backlight não controlado"
    fi
}

# Função para verificar se workspace foi movido
verify_workspace_on_monitor() {
    local workspace="$1"
    local monitor="$2"
    
    hyprctl workspaces | grep -A3 "workspace ID $workspace" | grep -q "Monitor: $monitor"
}

# Função que desliga eDP-1 com verificações
disable_edp_working_method() {
    log_message "🔧 Aplicando método melhorado para modo clamshell..."
    log_message "📺 Monitor externo detectado: $EXTERNAL_MONITOR"
    
    # Enviar notificação de início
    $HOME/.local/bin/monitor-notify "connecting" "$EXTERNAL_MONITOR" 2>/dev/null || true
    
    # 1. Desligar backlight do teclado
    control_keyboard_backlight "off"
    
    # 2. Criar configuração específica para clamshell
    cat > /home/francis/.config/hypr/conf.d/clamshell-loader.conf << EOF
# Loader para modo clamshell - ATIVO
# Monitor interno completamente desabilitado
monitor = eDP-1, disabled

# Monitor externo como principal
monitor = $EXTERNAL_MONITOR, preferred, 0x0, 1.0

# Workspace bindings para monitor externo
workspace = 1, monitor:$EXTERNAL_MONITOR
workspace = 2, monitor:$EXTERNAL_MONITOR
workspace = 3, monitor:$EXTERNAL_MONITOR
workspace = 4, monitor:$EXTERNAL_MONITOR
workspace = 5, monitor:$EXTERNAL_MONITOR
EOF
    
    # 3. Desligar tela do notebook com verificações
    if command -v hyprctl &> /dev/null; then
        # Forçar DPMS off antes do reload
        hyprctl dispatch dpms off "$INTERNAL_MONITOR"
        
        # Reload para aplicar nova configuração
        hyprctl reload
        
        # Aguardar reload completar
        sleep 1
        
        # Verificar se eDP-1 está desabilitado
        wait_for_monitor "$INTERNAL_MONITOR" "disabled"
        
        log_message "✅ Método aplicado - eDP-1 desligado"
    fi
    
    # Controle adicional de backlight da tela
    echo 0 | sudo tee /sys/class/backlight/*/brightness 2>/dev/null || true
    
    # Mover workspaces para monitor externo com verificação
    for i in {1..5}; do
        verify_hyprctl_command "dispatch moveworkspacetomonitor $i $EXTERNAL_MONITOR" \
            "verify_workspace_on_monitor $i $EXTERNAL_MONITOR" || true
    done
    
    # Focar workspace 1
    hyprctl dispatch workspace 1
    
    # Reiniciar waybar para garantir que apareça no monitor externo
    log_message "🔄 Reiniciando waybar para monitor externo..."
    $HOME/.local/bin/waybar-manager restart 2>/dev/null || true
    
    log_message "🎯 Clamshell mode ativado: tela OFF + backlight teclado OFF"
    
    # Salvar modo atual
    echo "clamshell" > /tmp/current-monitor-mode
    
    # Enviar notificação de sucesso
    $HOME/.local/bin/monitor-notify "clamshell" "$EXTERNAL_MONITOR" 2>/dev/null || true
}

# Função para reabilitar eDP-1 com verificações
enable_edp_dual_mode() {
    log_message "🔧 Reabilitando eDP-1 para modo dual monitor..."
    
    # Limpar configuração de clamshell
    cat > /home/francis/.config/hypr/conf.d/clamshell-loader.conf << EOF
# Loader condicional para modo clamshell
# Modo dual/single - arquivo vazio
EOF
    
    # Enviar notificação de início
    $HOME/.local/bin/monitor-notify "connecting" "$EXTERNAL_MONITOR" 2>/dev/null || true
    
    # 1. Ligar backlight do teclado no mínimo
    control_keyboard_backlight "low"
    
    # 2. Reabilitar tela do notebook com verificações
    if command -v hyprctl &> /dev/null; then
        # Reabilitar eDP-1
        verify_hyprctl_command "keyword monitor $INTERNAL_MONITOR,1920x1200@120,0x1080,1.25" \
            "wait_for_monitor $INTERNAL_MONITOR active"
        
        # Confirmar monitor externo
        verify_hyprctl_command "keyword monitor $EXTERNAL_MONITOR,preferred,0x0,1.0" \
            "wait_for_monitor $EXTERNAL_MONITOR active"
        
        # Distribuir workspaces com verificação
        for i in {1..4}; do
            verify_hyprctl_command "dispatch moveworkspacetomonitor $i $INTERNAL_MONITOR" \
                "verify_workspace_on_monitor $i $INTERNAL_MONITOR" || true
        done
        
        # Workspace 5 sempre no monitor externo
        verify_hyprctl_command "dispatch moveworkspacetomonitor 5 $EXTERNAL_MONITOR" \
            "verify_workspace_on_monitor 5 $EXTERNAL_MONITOR" || true
        
        hyprctl dispatch workspace 1
        
        # Reiniciar waybar para garantir configuração correta
        log_message "🔄 Reiniciando waybar para modo dual..."
        $HOME/.local/bin/waybar-manager restart 2>/dev/null || true
        
        log_message "✅ Modo dual monitor ativado: ambas telas ON + backlight teclado LOW"
        
        # Salvar modo atual
        echo "dual" > /tmp/current-monitor-mode
        
        # Enviar notificação de sucesso
        $HOME/.local/bin/monitor-notify "dual" "$EXTERNAL_MONITOR" 2>/dev/null || true
    fi
}

# Função para modo single monitor
enable_single_mode() {
    log_message "🔧 Configurando modo single monitor..."
    
    # Limpar configuração de clamshell
    cat > /home/francis/.config/hypr/conf.d/clamshell-loader.conf << EOF
# Loader condicional para modo clamshell
# Modo dual/single - arquivo vazio
EOF
    
    # Enviar notificação
    $HOME/.local/bin/monitor-notify "connecting" "Configurando..." 2>/dev/null || true
    
    # Ligar backlight do teclado no mínimo
    control_keyboard_backlight "low"
    
    # Configurar apenas monitor interno com verificação
    if command -v hyprctl &> /dev/null; then
        verify_hyprctl_command "keyword monitor $INTERNAL_MONITOR,1920x1200@120,0x0,1.25" \
            "wait_for_monitor $INTERNAL_MONITOR active"
        
        # Mover todos workspaces para interno com verificação
        for i in {1..5}; do
            verify_hyprctl_command "dispatch moveworkspacetomonitor $i $INTERNAL_MONITOR" \
                "verify_workspace_on_monitor $i $INTERNAL_MONITOR" || true
        done
        
        hyprctl dispatch workspace 1
        
        # Reiniciar waybar para garantir configuração correta
        log_message "🔄 Reiniciando waybar para modo single..."
        $HOME/.local/bin/waybar-manager restart 2>/dev/null || true
        
        log_message "✅ Modo single monitor: apenas eDP-1 + backlight teclado LOW"
        
        # Salvar modo atual
        echo "single" > /tmp/current-monitor-mode
        
        # Enviar notificação de sucesso
        $HOME/.local/bin/monitor-notify "single" 2>/dev/null || true
    fi
}

# Verificar estado do lid
check_lid_state() {
    LID_STATE="open"
    LID_FILE="/proc/acpi/button/lid/LID/state"
    
    if [ -f "$LID_FILE" ]; then
        if grep -q "closed" "$LID_FILE"; then
            LID_STATE="closed"
        fi
    fi
    
    echo "$LID_STATE"
}

# Verificar se monitor externo está conectado
check_external_monitor() {
    # Verificar se HDMI-A-1 está conectado
    if [ -f "/sys/class/drm/card1-HDMI-A-1/status" ]; then
        status=$(cat "/sys/class/drm/card1-HDMI-A-1/status" 2>/dev/null)
        if [ "$status" = "connected" ]; then
            echo "true"
            return
        fi
    fi
    
    # Verificar se DP-8 está conectado (monitor LG ULTRAWIDE)
    if [ -f "/sys/class/drm/card1-DP-8/status" ]; then
        status=$(cat "/sys/class/drm/card1-DP-8/status" 2>/dev/null)
        if [ "$status" = "connected" ]; then
            echo "true"
            return
        fi
    fi
    
    # Verificar outros DPs
    for dp in DP-1 DP-2 DP-3 DP-4 DP-5 DP-6 DP-7; do
        if [ -f "/sys/class/drm/card1-$dp/status" ]; then
            status=$(cat "/sys/class/drm/card1-$dp/status" 2>/dev/null)
            if [ "$status" = "connected" ]; then
                echo "true"
                return
            fi
        fi
    done
    
    # Fallback - verificar via hyprctl
    if command -v hyprctl &> /dev/null; then
        if hyprctl monitors | grep -qE "(HDMI-A-1|DP-[1-8])"; then
            echo "true"
            return
        fi
    fi
    
    echo "false"
}

# Função principal
main() {
    local action="${1:-auto}"
    
    log_message "=== CLAMSHELL MELHORADO - ROG Flow X13 ==="
    log_message "Ação solicitada: $action"
    
    case "$action" in
        "clamshell"|"disable")
            external_connected=$(check_external_monitor)
            if [ "$external_connected" = "true" ]; then
                log_message "Monitor externo conectado - ativando clamshell mode"
                disable_edp_working_method
                echo "✅ Modo clamshell: tela notebook OFF + backlight teclado OFF"
            else
                log_message "ERRO: Nenhum monitor externo detectado"
                echo "❌ Conecte um monitor externo primeiro"
                $HOME/.local/bin/monitor-notify "error" "Nenhum monitor externo detectado" 2>/dev/null || true
                exit 1
            fi
            ;;
            
        "dual"|"enable")
            enable_edp_dual_mode
            echo "✅ Modo dual: ambas telas ON + backlight teclado LOW"
            ;;
            
        "single")
            enable_single_mode
            echo "✅ Modo single: apenas notebook + backlight teclado LOW"
            ;;
            
        "auto")
            lid_state=$(check_lid_state)
            external_connected=$(check_external_monitor)
            
            log_message "Estado detectado - Lid: $lid_state, Monitor externo: $external_connected"
            
            if [ "$lid_state" = "closed" ] && [ "$external_connected" = "true" ]; then
                log_message "Condições para clamshell atendidas"
                disable_edp_working_method
                echo "✅ Clamshell automático: tela OFF + backlight teclado OFF"
            elif [ "$lid_state" = "open" ] && [ "$external_connected" = "true" ]; then
                log_message "Condições para dual monitor atendidas"
                enable_edp_dual_mode
                echo "✅ Dual automático: ambas telas + backlight teclado LOW"
            else
                log_message "Usando apenas monitor interno"
                enable_single_mode
                echo "✅ Single automático: apenas notebook + backlight teclado LOW"
            fi
            ;;
            
        "backlight-off")
            control_keyboard_backlight "off"
            echo "✅ Backlight do teclado: OFF"
            ;;
            
        "backlight-low")
            control_keyboard_backlight "low"
            echo "✅ Backlight do teclado: LOW"
            ;;
            
        "test")
            echo "=== TESTE MELHORADO ROG Flow X13 ==="
            echo "Lid: $(check_lid_state)"
            echo "Monitor externo: $(check_external_monitor)"
            echo "Backlight teclado: $(control_keyboard_backlight status)"
            echo "Log: $LOG_FILE"
            echo ""
            echo "Monitores:"
            hyprctl monitors | grep -E "(Monitor|HDMI-A-1|DP-8|eDP-1)" || echo "Hyprctl não disponível"
            ;;
            
        *)
            echo "Uso: $0 [clamshell|dual|single|auto|test|backlight-off|backlight-low]"
            echo ""
            echo "  clamshell     - Forçar modo clamshell (tela OFF + backlight OFF)"
            echo "  dual          - Forçar modo dual monitor (ambas telas + backlight LOW)"
            echo "  single        - Forçar modo single (só notebook + backlight LOW)"
            echo "  auto          - Detecção automática baseada no lid"
            echo "  test          - Mostrar status atual"
            echo "  backlight-off - Só desligar backlight do teclado"
            echo "  backlight-low - Só ligar backlight do teclado no mínimo"
            ;;
    esac
}

main "$@"