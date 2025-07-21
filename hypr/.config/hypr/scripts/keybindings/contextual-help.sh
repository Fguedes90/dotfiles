#!/bin/bash
# Script principal para detectar aplicação ativa e mostrar keybindings relevantes

# Diretórios de configuração
KEYBINDS_DIR="$HOME/.config/hypr/keybindings"
APPS_DIR="$KEYBINDS_DIR/apps"
CATEGORIES_DIR="$KEYBINDS_DIR/categories"
CACHE_DIR="/tmp/hypr-keybinds-cache"

# Criar diretório de cache se não existir
mkdir -p "$CACHE_DIR"

# Função para detectar aplicação ativa
detect_active_app() {
    local window_info=$(hyprctl activewindow -j 2>/dev/null)
    
    if [ -z "$window_info" ] || [ "$window_info" = "null" ]; then
        echo "none"
        return
    fi
    
    local app_class=$(echo "$window_info" | jq -r '.class // "unknown"' | tr '[:upper:]' '[:lower:]')
    local app_title=$(echo "$window_info" | jq -r '.title // "Unknown"')
    
    # Normalizar nomes de aplicações conhecidas
    case "$app_class" in
        "chromium"|"chromium-browser")
            app_class="chromium"
            ;;
        "com.mitchellh.ghostty"|"ghostty")
            app_class="ghostty"
            ;;
        "org.gnome.nautilus"|"nautilus")
            app_class="nautilus"
            ;;
        "claude"|"claude-desktop")
            app_class="claude-desktop"
            ;;
        "code"|"code-oss"|"vscodium")
            app_class="code"
            ;;
        "obsidian")
            app_class="obsidian"
            ;;
        "btop"|"btop++")
            app_class="btop"
            ;;
        "lazydocker")
            app_class="lazydocker"
            ;;
    esac
    
    echo "$app_class"
}

# Função para determinar categoria da aplicação
get_app_category() {
    local app_class="$1"
    
    case "$app_class" in
        code|vim|nvim|emacs|helix)
            echo "text-editors"
            ;;
        chromium|chrome|brave|firefox|edge)
            echo "browsers"
            ;;
        ghostty|kitty|alacritty|wezterm|gnome-terminal)
            echo "terminals"
            ;;
        nautilus|thunar|dolphin|nemo|pcmanfm)
            echo "file-managers"
            ;;
        claude-desktop|chatgpt)
            echo "ai-assistants"
            ;;
        obsidian|logseq|notion)
            echo "note-taking"
            ;;
        btop|htop|gotop|glances)
            echo "system-monitors"
            ;;
        lazydocker|docker|podman)
            echo "dev-tools"
            ;;
        *)
            echo "default"
            ;;
    esac
}

# Função para verificar cache
get_cached_keybinds() {
    local app="$1"
    local cache_file="$CACHE_DIR/${app}.cache"
    
    # Verificar se cache existe e é recente (menos de 1 hora)
    if [[ -f "$cache_file" ]] && [[ $(find "$cache_file" -mmin -60 2>/dev/null | wc -l) -gt 0 ]]; then
        cat "$cache_file"
        return 0
    fi
    
    return 1
}

# Função para salvar cache
save_to_cache() {
    local app="$1"
    local content="$2"
    local cache_file="$CACHE_DIR/${app}.cache"
    
    echo "$content" > "$cache_file"
}

# Função para processar arquivo YAML e converter para formato legível
process_yaml_file() {
    local yaml_file="$1"
    
    if [ ! -f "$yaml_file" ]; then
        return 1
    fi
    
    # Verificar se yq está instalado
    if ! command -v yq &> /dev/null; then
        # Fallback: usar parser simplificado em bash
        echo "[Processamento simplificado - instale 'yq' para melhor formatação]"
        echo ""
        cat "$yaml_file" | grep -E "^[[:space:]]*(- name:|key:|action:)" | \
            sed 's/^[[:space:]]*- name:/\n### /g' | \
            sed 's/^[[:space:]]*key:/  /g' | \
            sed 's/^[[:space:]]*action:/ → /g'
        return 0
    fi
    
    # Processar com yq (versão python/jq wrapper)
    local output=""
    
    # Obter nome e ícone da aplicação
    local app_name=$(yq -r '.application.name' "$yaml_file" 2>/dev/null)
    local icon=$(yq -r '.application.icon' "$yaml_file" 2>/dev/null)
    
    output="# $icon $app_name\n\n"
    
    # Processar categorias
    local categories=$(yq -r '.categories | length' "$yaml_file" 2>/dev/null)
    
    for ((i=0; i<categories; i++)); do
        local cat_name=$(yq -r ".categories[$i].name" "$yaml_file" 2>/dev/null)
        output+="### $cat_name\n"
        
        local keybindings=$(yq -r ".categories[$i].keybindings | length" "$yaml_file" 2>/dev/null)
        
        for ((j=0; j<keybindings; j++)); do
            local key=$(yq -r ".categories[$i].keybindings[$j].key" "$yaml_file" 2>/dev/null)
            local action=$(yq -r ".categories[$i].keybindings[$j].action" "$yaml_file" 2>/dev/null)
            output+="  $key → $action\n"
        done
        
        output+="\n"
    done
    
    echo -e "$output"
}

# Função para combinar keybindings da aplicação com os do Hyprland
combine_keybindings() {
    local app_content="$1"
    local app_name="$2"
    
    # Adicionar keybindings universais do Hyprland
    local hyprland_keybinds="
### 🪟 Controles de Janela (Hyprland)
  SUPER + Q → Fechar janela
  SUPER + F → Tela cheia
  SUPER + V → Alternar flutuante
  SUPER + P → Pseudo tile
  SUPER + G → Alternar grupo
  SUPER + SHIFT + P → Pin janela

### 🚀 Navegação (Hyprland)
  SUPER + H/J/K/L → Mover foco
  SUPER + 1-5 → Ir para workspace
  SUPER + Tab → Próxima janela no grupo
  SUPER + Scroll → Navegar workspaces

### 📱 Sistema (Hyprland)
  SUPER + SHIFT + R → Recarregar config
  SUPER + X → Menu logout
  SUPER + L → Bloquear tela
  SUPER + K → Mostrar todos keybindings
  SUPER + F1 → Help contextual (este menu)
"
    
    echo "$app_content"
    echo ""
    echo "$hyprland_keybinds"
}

# Função principal para apresentar keybindings
present_keybindings() {
    local app_class="$1"
    local app_name="$2"
    
    # Tentar cache primeiro
    if cached_content=$(get_cached_keybinds "$app_class"); then
        echo "$cached_content" | wofi --dmenu \
            --prompt "Keybindings: $app_name" \
            --width 700 \
            --height 80% \
            --style "$HOME/.local/share/omarchy/default/wofi/search.css" \
            --cache-file /dev/null
        return
    fi
    
    local keybinds_content=""
    local found_specific=false
    
    # Verificar se existe arquivo específico para a aplicação
    if [ -f "$APPS_DIR/${app_class}.yaml" ]; then
        keybinds_content=$(process_yaml_file "$APPS_DIR/${app_class}.yaml")
        found_specific=true
    else
        # Tentar categoria
        local category=$(get_app_category "$app_class")
        if [ -f "$CATEGORIES_DIR/${category}.yaml" ]; then
            keybinds_content=$(process_yaml_file "$CATEGORIES_DIR/${category}.yaml")
        else
            # Usar default
            if [ -f "$APPS_DIR/default.yaml" ]; then
                keybinds_content=$(process_yaml_file "$APPS_DIR/default.yaml")
            else
                keybinds_content="# ⚠️ Nenhuma configuração específica encontrada para: $app_name"
            fi
        fi
    fi
    
    # Combinar com keybindings do Hyprland
    local final_content=$(combine_keybindings "$keybinds_content" "$app_name")
    
    # Salvar no cache
    save_to_cache "$app_class" "$final_content"
    
    # Apresentar com wofi
    echo "$final_content" | wofi --dmenu \
        --prompt "Keybindings: $app_name" \
        --width 700 \
        --height 80% \
        --style "$HOME/.local/share/omarchy/default/wofi/search.css" \
        --cache-file /dev/null
}

# Main
main() {
    # Detectar aplicação ativa
    local app_class=$(detect_active_app)
    
    if [ "$app_class" = "none" ]; then
        # Nenhuma janela ativa - mostrar keybindings gerais
        /home/francis/.local/bin/show-all-keybindings
        exit 0
    fi
    
    # Obter informações da janela para o título
    local window_info=$(hyprctl activewindow -j 2>/dev/null)
    local app_title=$(echo "$window_info" | jq -r '.title // "Unknown"' | cut -c1-50)
    
    # Apresentar keybindings
    present_keybindings "$app_class" "$app_title"
}

# Executar
main "$@"