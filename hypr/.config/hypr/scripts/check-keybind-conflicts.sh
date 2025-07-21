#!/bin/bash
# Script para detectar conflitos de keybindings no Hyprland

# Cores para output
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔍 Verificando conflitos de keybindings...${NC}"
echo ""

# Diretórios para verificar
USER_DIR="$HOME/.config/hypr"
OMARCHY_DIR="$HOME/.local/share/omarchy/default/hypr"

# Arquivo temporário para armazenar todos os binds
TEMP_FILE=$(mktemp)
CONFLICTS_FILE=$(mktemp)

# Função para extrair keybinds de um arquivo
extract_keybinds() {
    local file="$1"
    local source="$2"
    
    # Procura por bind = ou bindl = ou binde = etc, ignora unbind
    grep -n "^[[:space:]]*bind[^[:space:]]*[[:space:]]*=" "$file" 2>/dev/null | \
    grep -v "unbind" | \
    while IFS=: read -r line_num content; do
        # Extrai modificador e tecla
        # Formato: bind = MOD, KEY, action...
        keybind=$(echo "$content" | sed 's/^[[:space:]]*bind[^=]*=[[:space:]]*//' | cut -d',' -f1,2 | sed 's/[[:space:]]*//g')
        
        if [ ! -z "$keybind" ]; then
            echo "$keybind|$file:$line_num|$source" >> "$TEMP_FILE"
        fi
    done
}

# Coletar keybinds do usuário
echo -e "${BLUE}Analisando configurações do usuário...${NC}"
find "$USER_DIR" -name "*.conf" -type f -not -path "*/backups/*" 2>/dev/null | while read -r file; do
    extract_keybinds "$file" "USER"
done

# Coletar keybinds do Omarchy
echo -e "${BLUE}Analisando configurações do Omarchy...${NC}"
find "$OMARCHY_DIR" -name "*.conf" -type f 2>/dev/null | while read -r file; do
    extract_keybinds "$file" "OMARCHY"
done

# Ordenar e procurar duplicatas
sort -t'|' -k1,1 "$TEMP_FILE" | \
awk -F'|' '
{
    key = $1
    location = $2
    source = $3
    
    if (key == prev_key) {
        if (!printed_prev) {
            print prev_key "|" prev_location "|" prev_source
            printed_prev = 1
        }
        print key "|" location "|" source
        conflicts_found = 1
    } else {
        printed_prev = 0
    }
    
    prev_key = key
    prev_location = location
    prev_source = source
}
END {
    if (conflicts_found) exit 1
}
' > "$CONFLICTS_FILE"

# Mostrar resultados
if [ -s "$CONFLICTS_FILE" ]; then
    echo ""
    echo -e "${RED}⚠️  CONFLITOS ENCONTRADOS:${NC}"
    echo ""
    
    current_key=""
    while IFS='|' read -r keybind location source; do
        if [ "$keybind" != "$current_key" ]; then
            echo ""
            echo -e "${YELLOW}Conflito: ${keybind}${NC}"
            current_key="$keybind"
        fi
        
        if [ "$source" = "OMARCHY" ]; then
            echo -e "  ${BLUE}[OMARCHY]${NC} $location"
        else
            echo -e "  ${GREEN}[USER]${NC}    $location"
        fi
    done < "$CONFLICTS_FILE"
    
    echo ""
    echo -e "${RED}Total de conflitos: $(cat "$CONFLICTS_FILE" | cut -d'|' -f1 | sort -u | wc -l)${NC}"
    
    # Sugestões
    echo ""
    echo -e "${BLUE}💡 SUGESTÕES:${NC}"
    echo "1. Use 'unbind = MOD, KEY' antes de redefinir um keybind do Omarchy"
    echo "2. Considere usar modificadores diferentes (SUPER SHIFT, SUPER ALT)"
    echo "3. Verifique conflict-resolution.conf para exemplos"
else
    echo ""
    echo -e "${GREEN}✅ Nenhum conflito encontrado!${NC}"
fi

# Estatísticas
echo ""
echo -e "${BLUE}📊 ESTATÍSTICAS:${NC}"
echo -e "Total de keybinds do usuário: $(find "$USER_DIR" -name "*.conf" -not -path "*/backups/*" -exec grep -h "^[[:space:]]*bind" {} \; 2>/dev/null | grep -v unbind | wc -l)"
echo -e "Total de keybinds do Omarchy: $(grep -h "^[[:space:]]*bind" "$OMARCHY_DIR"/**/*.conf 2>/dev/null | grep -v unbind | wc -l)"
echo -e "Unbinds definidos: $(find "$USER_DIR" -name "*.conf" -not -path "*/backups/*" -exec grep -h "^[[:space:]]*unbind" {} \; 2>/dev/null | wc -l)"

# Cleanup
rm -f "$TEMP_FILE" "$CONFLICTS_FILE"

echo ""
echo -e "${BLUE}Para mais detalhes, veja: ~/.config/hypr/KEYBINDING-CONFLICT-MATRIX.md${NC}"