#!/bin/bash
# Script de instalação dos dotfiles

set -e

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Instalador de Dotfiles ===${NC}"

# Verificar se stow está instalado
if ! command -v stow &> /dev/null; then
    echo -e "${RED}Erro: GNU Stow não está instalado${NC}"
    echo "Instale com: sudo pacman -S stow"
    exit 1
fi

# Verificar se está no diretório correto
if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${RED}Erro: Execute este script do diretório ~/dotfiles${NC}"
    exit 1
fi

cd "$DOTFILES_DIR"

# Função para fazer backup e criar links
install_config() {
    local package=$1
    local target_dir=$2
    
    echo -e "${YELLOW}Instalando $package...${NC}"
    
    # Fazer backup se existir
    if [ -d "$target_dir" ] || [ -L "$target_dir" ]; then
        mkdir -p "$BACKUP_DIR"
        echo "  Fazendo backup de $target_dir"
        cp -r "$target_dir" "$BACKUP_DIR/" 2>/dev/null || true
        rm -rf "$target_dir"
    fi
    
    # Criar diretório pai se não existir
    mkdir -p "$(dirname "$target_dir")"
    
    # Aplicar stow
    stow -v "$package"
    
    echo -e "${GREEN}  ✓ $package instalado${NC}"
}

# Menu de seleção
echo ""
echo "O que você deseja instalar?"
echo "1) Tudo"
echo "2) Apenas Hyprland + Waybar"
echo "3) Apenas Terminal (Alacritty + Shell)"
echo "4) Apenas Editores (Neovim)"
echo "5) Apenas Utilitários (btop, lazygit, etc)"
echo "6) Selecionar individualmente"
echo ""
read -p "Escolha uma opção [1-6]: " choice

case $choice in
    1)
        echo -e "\n${YELLOW}Instalando todas as configurações...${NC}"
        install_config "hyprland" "$HOME/.config/hypr"
        install_config "waybar" "$HOME/.config/waybar"
        install_config "scripts" "$HOME/.local/bin"
        install_config "alacritty" "$HOME/.config/alacritty"
        install_config "nvim" "$HOME/.config/nvim"
        install_config "wofi" "$HOME/.config/wofi"
        install_config "btop" "$HOME/.config/btop"
        install_config "shell" "$HOME"
        install_config "git" "$HOME"
        install_config "fastfetch" "$HOME/.config/fastfetch"
        install_config "lazygit" "$HOME/.config/lazygit"
        install_config "lazydocker" "$HOME/.config/lazydocker"
        ;;
    2)
        install_config "hyprland" "$HOME/.config/hypr"
        install_config "waybar" "$HOME/.config/waybar"
        install_config "wofi" "$HOME/.config/wofi"
        install_config "scripts" "$HOME/.local/bin"
        ;;
    3)
        install_config "alacritty" "$HOME/.config/alacritty"
        install_config "shell" "$HOME"
        ;;
    4)
        install_config "nvim" "$HOME/.config/nvim"
        ;;
    5)
        install_config "btop" "$HOME/.config/btop"
        install_config "git" "$HOME"
        install_config "fastfetch" "$HOME/.config/fastfetch"
        install_config "lazygit" "$HOME/.config/lazygit"
        install_config "lazydocker" "$HOME/.config/lazydocker"
        ;;
    6)
        read -p "Instalar Hyprland? [y/N]: " yn
        [[ $yn == [yY] ]] && install_config "hyprland" "$HOME/.config/hypr"
        
        read -p "Instalar Waybar? [y/N]: " yn
        [[ $yn == [yY] ]] && install_config "waybar" "$HOME/.config/waybar"
        
        read -p "Instalar Wofi? [y/N]: " yn
        [[ $yn == [yY] ]] && install_config "wofi" "$HOME/.config/wofi"
        
        read -p "Instalar Scripts? [y/N]: " yn
        [[ $yn == [yY] ]] && install_config "scripts" "$HOME/.local/bin"
        
        read -p "Instalar Alacritty? [y/N]: " yn
        [[ $yn == [yY] ]] && install_config "alacritty" "$HOME/.config/alacritty"
        
        read -p "Instalar Neovim? [y/N]: " yn
        [[ $yn == [yY] ]] && install_config "nvim" "$HOME/.config/nvim"
        
        read -p "Instalar Shell configs? [y/N]: " yn
        [[ $yn == [yY] ]] && install_config "shell" "$HOME"
        
        read -p "Instalar Git config? [y/N]: " yn
        [[ $yn == [yY] ]] && install_config "git" "$HOME"
        
        read -p "Instalar btop? [y/N]: " yn
        [[ $yn == [yY] ]] && install_config "btop" "$HOME/.config/btop"
        
        read -p "Instalar fastfetch? [y/N]: " yn
        [[ $yn == [yY] ]] && install_config "fastfetch" "$HOME/.config/fastfetch"
        
        read -p "Instalar lazygit? [y/N]: " yn
        [[ $yn == [yY] ]] && install_config "lazygit" "$HOME/.config/lazygit"
        
        read -p "Instalar lazydocker? [y/N]: " yn
        [[ $yn == [yY] ]] && install_config "lazydocker" "$HOME/.config/lazydocker"
        ;;
    *)
        echo -e "${RED}Opção inválida${NC}"
        exit 1
        ;;
esac

echo -e "\n${GREEN}=== Instalação concluída ===${NC}"

if [ -d "$BACKUP_DIR" ]; then
    echo -e "${YELLOW}Backup das configurações anteriores em: $BACKUP_DIR${NC}"
fi

echo ""
echo "Para desinstalar, use:"
echo "  cd ~/dotfiles"
echo "  stow -D hyprland waybar scripts"