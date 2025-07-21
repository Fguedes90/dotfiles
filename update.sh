#!/bin/bash
# Script para atualizar configurações no repositório dotfiles

set -e

DOTFILES_DIR="$HOME/dotfiles"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Atualizador de Dotfiles ===${NC}"

cd "$DOTFILES_DIR"

# Função para atualizar configuração
update_config() {
    local package=$1
    local source_dir=$2
    local dest_dir="$DOTFILES_DIR/$package/${source_dir#$HOME/}"
    
    echo -e "${YELLOW}Atualizando $package...${NC}"
    
    if [ ! -d "$source_dir" ]; then
        echo -e "${RED}  Aviso: $source_dir não existe${NC}"
        return
    fi
    
    # Criar diretório de destino se não existir
    mkdir -p "$(dirname "$dest_dir")"
    
    # Sincronizar arquivos
    rsync -av --delete "$source_dir/" "$dest_dir/"
    
    echo -e "${GREEN}  ✓ $package atualizado${NC}"
}

# Menu
echo ""
echo "O que você deseja atualizar no repositório?"
echo "1) Tudo"
echo "2) Apenas Hyprland"
echo "3) Apenas Waybar"
echo "4) Apenas Scripts"
echo "5) Ver diferenças"
echo ""
read -p "Escolha uma opção [1-5]: " choice

case $choice in
    1)
        # Atualizar todas as configurações
        update_config "hyprland" "$HOME/.config/hypr"
        update_config "waybar" "$HOME/.config/waybar"
        update_config "alacritty" "$HOME/.config/alacritty"
        update_config "nvim" "$HOME/.config/nvim"
        update_config "wofi" "$HOME/.config/wofi"
        update_config "btop" "$HOME/.config/btop"
        update_config "fastfetch" "$HOME/.config/fastfetch"
        update_config "lazygit" "$HOME/.config/lazygit"
        update_config "lazydocker" "$HOME/.config/lazydocker"
        
        # Atualizar arquivos individuais
        echo -e "${YELLOW}Atualizando shell configs...${NC}"
        cp -v $HOME/.zshrc $DOTFILES_DIR/shell/ 2>/dev/null || true
        cp -v $HOME/.bashrc $DOTFILES_DIR/shell/ 2>/dev/null || true
        cp -v $HOME/.bash_profile $DOTFILES_DIR/shell/ 2>/dev/null || true
        echo -e "${GREEN}  ✓ Shell configs atualizados${NC}"
        
        echo -e "${YELLOW}Atualizando git config...${NC}"
        cp -v $HOME/.gitconfig $DOTFILES_DIR/git/ 2>/dev/null || true
        echo -e "${GREEN}  ✓ Git config atualizado${NC}"
        
        # Atualizar scripts
        echo -e "${YELLOW}Atualizando scripts...${NC}"
        cp -v $HOME/.local/bin/waybar-* $DOTFILES_DIR/scripts/.local/bin/ 2>/dev/null || true
        cp -v $HOME/.local/bin/*monitor* $DOTFILES_DIR/scripts/.local/bin/ 2>/dev/null || true
        cp -v $HOME/.local/bin/*volume* $DOTFILES_DIR/scripts/.local/bin/ 2>/dev/null || true
        echo -e "${GREEN}  ✓ Scripts atualizados${NC}"
        ;;
    2)
        update_config "hyprland" "$HOME/.config/hypr"
        ;;
    3)
        update_config "waybar" "$HOME/.config/waybar"
        ;;
    4)
        echo -e "${YELLOW}Atualizando scripts...${NC}"
        cp -v $HOME/.local/bin/waybar-* $DOTFILES_DIR/scripts/.local/bin/ 2>/dev/null || true
        cp -v $HOME/.local/bin/*monitor* $DOTFILES_DIR/scripts/.local/bin/ 2>/dev/null || true
        cp -v $HOME/.local/bin/*volume* $DOTFILES_DIR/scripts/.local/bin/ 2>/dev/null || true
        echo -e "${GREEN}  ✓ Scripts atualizados${NC}"
        ;;
    5)
        echo -e "\n${BLUE}=== Diferenças encontradas ===${NC}"
        
        for config in hyprland waybar alacritty nvim wofi btop; do
            echo -e "\n${YELLOW}$config:${NC}"
            diff -r "$HOME/.config/$config" "$DOTFILES_DIR/$config/.config/$config" 2>/dev/null || true
        done
        
        echo -e "\n${YELLOW}Shell configs:${NC}"
        diff "$HOME/.zshrc" "$DOTFILES_DIR/shell/.zshrc" 2>/dev/null || true
        diff "$HOME/.bashrc" "$DOTFILES_DIR/shell/.bashrc" 2>/dev/null || true
        
        echo -e "\n${YELLOW}Git config:${NC}"
        diff "$HOME/.gitconfig" "$DOTFILES_DIR/git/.gitconfig" 2>/dev/null || true
        ;;
    *)
        echo -e "${RED}Opção inválida${NC}"
        exit 1
        ;;
esac

echo -e "\n${GREEN}=== Atualização concluída ===${NC}"
echo ""
echo "Próximos passos:"
echo "1. cd ~/dotfiles"
echo "2. git add ."
echo "3. git commit -m 'Atualizar configurações'"
echo "4. git push"