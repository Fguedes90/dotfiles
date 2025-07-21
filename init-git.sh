#!/bin/bash
# Script para inicializar repositório git

set -e

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}=== Inicializando repositório Git ===${NC}"

cd ~/dotfiles

# Inicializar git se não existir
if [ ! -d .git ]; then
    git init
    echo -e "${GREEN}✓ Repositório git inicializado${NC}"
else
    echo -e "${YELLOW}Repositório git já existe${NC}"
fi

# Adicionar todos os arquivos
git add .

# Criar commit inicial
git commit -m "Initial commit: Hyprland + Waybar configs com modo clamshell" || true

echo -e "\n${GREEN}=== Repositório pronto ===${NC}"
echo ""
echo "Próximos passos:"
echo "1. Criar repositório no GitHub/GitLab"
echo "2. Adicionar remote:"
echo "   git remote add origin https://github.com/SEU_USUARIO/dotfiles.git"
echo "3. Push inicial:"
echo "   git push -u origin main"