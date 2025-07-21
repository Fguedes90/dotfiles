# Estrutura do Repositório Dotfiles

## Visão Geral

Este repositório usa GNU Stow para gerenciar links simbólicos das configurações.

## Estrutura de Diretórios

```
dotfiles/
│
├── hyprland/                      # Pacote Hyprland
│   └── .config/
│       └── hypr/
│           ├── hyprland.conf      # Configuração principal
│           ├── hyprlock.conf      # Configuração do lockscreen
│           ├── conf.d/            # Configurações modulares
│           │   ├── autostart.conf
│           │   ├── keybinds.conf
│           │   ├── locale-br.conf
│           │   ├── monitors.conf
│           │   ├── workspaces.conf
│           │   ├── clamshell-loader.conf  # Dinâmico (ignorado no git)
│           │   └── devices/
│           │       └── rog-flow-x13.conf
│           └── scripts/
│               ├── display/
│               │   ├── clamshell.sh       # Gerenciador de modos
│               │   ├── lid-switch.sh      # Detector de tampa
│               │   └── monitor-mode-status.sh
│               └── workspace/
│                   └── navigate.sh
│
├── waybar/                        # Pacote Waybar
│   └── .config/
│       └── waybar/
│           ├── config             # Configuração com módulo monitor-mode
│           └── style.css          # Estilos incluindo cores S/D/C
│
├── scripts/                       # Scripts utilitários
│   └── .local/
│       └── bin/
│           ├── waybar-manager
│           ├── waybar-monitor-daemon
│           ├── monitor-notify
│           ├── volume-notify
│           └── volume-notify-mako
│
├── install.sh                     # Script de instalação interativo
├── update.sh                      # Script para atualizar configs no repo
├── init-git.sh                    # Inicializar repositório git
├── README.md                      # Documentação principal
├── STRUCTURE.md                   # Este arquivo
└── .gitignore                     # Arquivos ignorados

```

## Como Funciona o Stow

O GNU Stow cria links simbólicos da estrutura dentro de cada pacote para o sistema:

- `~/dotfiles/hyprland/.config/hypr/` → `~/.config/hypr/`
- `~/dotfiles/waybar/.config/waybar/` → `~/.config/waybar/`
- `~/dotfiles/scripts/.local/bin/` → `~/.local/bin/`

## Comandos Úteis

```bash
# Aplicar todas as configurações
cd ~/dotfiles
stow hyprland waybar scripts

# Aplicar apenas uma
stow hyprland

# Remover links
stow -D hyprland

# Recriar links (após mudanças)
stow -R hyprland

# Ver o que seria feito (dry run)
stow -n hyprland

# Verbose (mostrar o que está fazendo)
stow -v hyprland
```

## Fluxo de Trabalho

1. **Fazer mudanças**: Edite os arquivos em `~/.config/` normalmente
2. **Atualizar repo**: Execute `~/dotfiles/update.sh`
3. **Commit**: `cd ~/dotfiles && git add . && git commit`
4. **Push**: `git push`

## Modo Clamshell

O sistema detecta automaticamente 3 modos:
- **S** (Single): Apenas notebook
- **D** (Dual): Notebook + monitor externo
- **C** (Clamshell): Tampa fechada, apenas monitor externo

A waybar mostra um indicador visual colorido do modo atual.