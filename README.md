# Dotfiles - Francis

Este repositório contém minhas configurações pessoais organizadas com GNU Stow.

## Estrutura

```
dotfiles/
├── hyprland/          # Configurações do Hyprland
│   └── .config/
│       └── hypr/
├── waybar/            # Configurações da Waybar
│   └── .config/
│       └── waybar/
├── alacritty/         # Terminal Alacritty
│   └── .config/
│       └── alacritty/
├── nvim/              # Neovim (LazyVim)
│   └── .config/
│       └── nvim/
├── wofi/              # Launcher
│   └── .config/
│       └── wofi/
├── btop/              # Monitor de sistema
│   └── .config/
│       └── btop/
├── fastfetch/         # System info
│   └── .config/
│       └── fastfetch/
├── lazygit/           # Git UI
│   └── .config/
│       └── lazygit/
├── lazydocker/        # Docker UI
│   └── .config/
│       └── lazydocker/
├── shell/             # Shell configs
│   ├── .zshrc
│   ├── .bashrc
│   └── .bash_profile
├── git/               # Git config
│   └── .gitconfig
└── scripts/           # Scripts utilitários
    └── .local/
        └── bin/
```

## Instalação

### Pré-requisitos

```bash
# Arch Linux
sudo pacman -S stow git

# Debian/Ubuntu
sudo apt install stow git
```

### Clonar e aplicar configurações

```bash
# Clonar repositório (quando estiver no git)
cd ~
git clone https://github.com/SEU_USUARIO/dotfiles.git

# Fazer backup das configurações atuais
mkdir -p ~/.config-backup
mv ~/.config/hypr ~/.config-backup/
mv ~/.config/waybar ~/.config-backup/

# Aplicar configurações com stow
cd ~/dotfiles
stow hyprland
stow waybar
stow scripts
```

## Gerenciamento

### Aplicar uma configuração específica
```bash
cd ~/dotfiles
stow hyprland
```

### Remover links simbólicos
```bash
cd ~/dotfiles
stow -D hyprland
```

### Recriar links (útil após mudanças)
```bash
cd ~/dotfiles
stow -R hyprland
```

## Configurações incluídas

### Hyprland
- Configuração principal: `hyprland.conf`
- Configurações modulares em `conf.d/`:
  - `monitors.conf` - Configuração de monitores
  - `autostart.conf` - Aplicações iniciadas automaticamente
  - `keybinds.conf` - Atalhos de teclado
  - `locale-br.conf` - Configurações de localização
  - `workspaces.conf` - Configuração de workspaces
  - `clamshell-loader.conf` - Loader dinâmico para modo clamshell
  - `devices/rog-flow-x13.conf` - Configurações específicas do ASUS ROG Flow X13

### Scripts de gerenciamento de display
- `clamshell.sh` - Gerenciamento automático de modos de monitor
- `lid-switch.sh` - Detecção de abertura/fechamento da tampa
- `monitor-mode-status.sh` - Status do modo atual para waybar

### Waybar
- Configuração com indicador de modo de monitor
- Estilos customizados para diferentes modos
- Módulos: workspaces, clock, bluetooth, network, audio, cpu, battery

### Alacritty
- Terminal configurado com tema personalizado
- Font: CaskaydiaMono Nerd Font

### Neovim
- Configuração LazyVim completa
- Plugins e configurações personalizadas
- LSP, formatadores e linters configurados

### Wofi
- Launcher estilizado
- Integração com tema Omarchy

### Shell
- ZSH com Oh My Zsh
- Bash configurado
- Aliases e funções customizadas

### Git
- Aliases úteis (co, br, ci, st)
- Configurações de usuário
- Pull com rebase por padrão

### Utilitários
- **btop** - Monitor de sistema com tema personalizado
- **fastfetch** - System info customizado
- **lazygit** - Interface TUI para git
- **lazydocker** - Interface TUI para docker

### Scripts utilitários
- `waybar-manager` - Gerenciador da waybar
- `waybar-monitor-daemon` - Daemon para evitar múltiplas instâncias
- `monitor-notify` - Notificações de mudança de monitor
- `volume-notify-mako` - Notificações de volume

## Notas

- O modo clamshell desabilita completamente o monitor interno quando a tampa está fechada
- A waybar mostra um indicador visual do modo atual (S/D/C)
- Scripts são executados automaticamente ao detectar mudanças de hardware