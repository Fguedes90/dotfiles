# 🎯 Melhorias Intuitivas para Keybindings

## 🔑 Mudanças Propostas para Máxima Intuitividade

### 1. App Launchers Mnemônicos
```conf
# ~/.config/hypr/conf.d/intuitive-apps.conf
# Cada app na primeira letra do nome

# 🌐 Browser (B)
unbind = SUPER, B
bind = SUPER, B, exec, chromium

# 📁 Files (F) 
unbind = SUPER, F  # Era fullscreen
bind = SUPER, F, exec, nautilus
bind = SUPER SHIFT, F, fullscreen  # Fullscreen movido

# 📧 Email (E)
bind = SUPER, E, exec, thunderbird

# 🎵 Music (M)
bind = SUPER, M, exec, spotify

# 💬 Discord (D)
unbind = SUPER, D  # Era show desktop
bind = SUPER, D, exec, discord
bind = SUPER SHIFT, D, exec, hyprctl dispatch workspace empty  # Desktop

# 📝 Notes - Obsidian (N)
bind = SUPER, N, exec, obsidian

# 🎮 Games - Steam (G)
unbind = SUPER, G  # Era toggle group
bind = SUPER, G, exec, steam
bind = SUPER SHIFT, G, togglegroup  # Group movido
```

### 2. Navegação Natural
```conf
# ~/.config/hypr/conf.d/natural-navigation.conf

# Home row para navegação (mais ergonômico que HJKL)
bind = SUPER, A, movefocus, l     # A = Left (All left)
bind = SUPER, S, movefocus, d     # S = Down (Sink)
bind = SUPER, W, movefocus, u     # W = Up (Way up)
bind = SUPER, D, movefocus, r     # D = Right (Direction)

# HJKL ainda disponível para usuários Vim
bind = SUPER ALT, H, movefocus, l
bind = SUPER ALT, J, movefocus, d
bind = SUPER ALT, K, movefocus, u
bind = SUPER ALT, L, movefocus, r

# Workspace navigation intuitiva
bind = SUPER, comma, workspace, -1        # < Previous
bind = SUPER, period, workspace, +1       # > Next
bind = SUPER, slash, workspace, previous  # / Last used
```

### 3. Ações Contextuais Inteligentes
```conf
# ~/.config/hypr/conf.d/smart-actions.conf

# SUPER + Enter = Terminal OU novo painel no terminal atual
bind = SUPER, Return, exec, ~/.config/hypr/scripts/smart-terminal.sh

# SUPER + O = Open (contexto sensitivo)
bind = SUPER, O, exec, ~/.config/hypr/scripts/smart-open.sh
# - No file manager: open file
# - No browser: open URL  
# - No editor: open file dialog

# SUPER + S = Smart Save/Search
bind = SUPER, S, exec, ~/.config/hypr/scripts/smart-action.sh save
# - Editor: Save file
# - Browser: Save page
# - Terminal: Save output
# - Default: Screenshot

# SUPER + F = Smart Find
bind = SUPER CTRL, F, exec, ~/.config/hypr/scripts/smart-action.sh find
# - Any app: Find in page/document
# - File manager: Find files
# - Terminal: Search history
```

### 4. Modo de Comando Universal
```conf
# ~/.config/hypr/conf.d/command-mode.conf

# SUPER + : (dois pontos como Vim)
bind = SUPER, colon, exec, ~/.config/hypr/scripts/command-mode.sh

# Comandos disponíveis:
# :q     - quit current window
# :qa    - quit all
# :w     - save (context aware)
# :e     - edit/open file
# :term  - new terminal
# :web   - new browser
# :lock  - lock screen
# :sleep - suspend
# :reload - reload config
```

### 5. Quick Switcher Melhorado
```conf
# ~/.config/hypr/conf.d/quick-switch.conf

# SUPER + Tab = Switcher visual inteligente
bind = SUPER, Tab, exec, ~/.config/hypr/scripts/visual-switcher.sh

# Features:
# - Mostra preview das janelas
# - Agrupa por aplicação
# - Busca por título
# - Números para seleção rápida (1-9)
# - J/K para navegar
# - / para filtrar
```

### 6. Resize Intuitivo
```conf
# ~/.config/hypr/conf.d/intuitive-resize.conf

# Modo resize melhorado
bind = SUPER, R, submap, resize
submap = resize

# Teclas intuitivas
bind = , left, resizeactive, -50 0
bind = , right, resizeactive, 50 0
bind = , up, resizeactive, 0 -50
bind = , down, resizeactive, 0 50

# Precisão
bind = SHIFT, left, resizeactive, -10 0
bind = SHIFT, right, resizeactive, 10 0
bind = SHIFT, up, resizeactive, 0 -10
bind = SHIFT, down, resizeactive, 0 10

# Presets
bind = , 1, resizeactive, exact 33% 100%   # 1/3 tela
bind = , 2, resizeactive, exact 50% 100%   # 1/2 tela  
bind = , 3, resizeactive, exact 67% 100%   # 2/3 tela
bind = , 0, resizeactive, exact 100% 100%  # Maximizar

# Sair
bind = , escape, submap, reset
bind = , q, submap, reset
submap = reset
```

### 7. Media Controls Universais
```conf
# ~/.config/hypr/conf.d/media-universal.conf

# Play/Pause em qualquer lugar
bind = , XF86AudioPlay, exec, playerctl play-pause
bind = SUPER, space, exec, playerctl play-pause  # Backup

# Volume com feedback visual
bind = , XF86AudioRaiseVolume, exec, ~/.config/hypr/scripts/volume.sh up
bind = , XF86AudioLowerVolume, exec, ~/.config/hypr/scripts/volume.sh down
bind = , XF86AudioMute, exec, ~/.config/hypr/scripts/volume.sh mute

# Atalhos alternativos intuitivos
bind = SUPER, equal, exec, ~/.config/hypr/scripts/volume.sh up    # + volume
bind = SUPER, minus, exec, ~/.config/hypr/scripts/volume.sh down  # - volume
bind = SUPER, 0, exec, ~/.config/hypr/scripts/volume.sh mute      # 0 = mute
```

---

## 📝 Scripts de Suporte

### smart-terminal.sh
```bash
#!/bin/bash
# Abre terminal ou split se já em terminal

if [[ $(hyprctl activewindow -j | jq -r '.class') == "ghostty" ]]; then
    # Já em terminal - enviar comando de split
    wtype -M ctrl -M shift -P Return
else
    # Abrir novo terminal
    ghostty
fi
```

### smart-action.sh
```bash
#!/bin/bash
# Ações contextuais baseadas na aplicação ativa

ACTION=$1
APP=$(hyprctl activewindow -j | jq -r '.class' | tr '[:upper:]' '[:lower:]')

case "$ACTION" in
    "save")
        case "$APP" in
            code|vim|nvim) wtype -M ctrl -P s ;;
            chromium|firefox) wtype -M ctrl -P s ;;
            *) grimblast save area ;;
        esac
        ;;
    "find")
        case "$APP" in
            *) wtype -M ctrl -P f ;;
        esac
        ;;
esac
```

### visual-switcher.sh
```bash
#!/bin/bash
# Switcher visual com preview

# Gera lista de janelas com títulos
windows=$(hyprctl clients -j | jq -r '.[] | "\(.workspace.id):\(.workspace.name) | \(.class) | \(.title)"')

# Mostra com wofi e ícones
selected=$(echo "$windows" | wofi --dmenu \
    --prompt "Switch to window" \
    --width 800 \
    --height 400 \
    --cache-file /dev/null)

# Extrai informações e foca
if [ -n "$selected" ]; then
    # Parse e switch
    workspace=$(echo "$selected" | cut -d: -f1)
    hyprctl dispatch workspace "$workspace"
fi
```

---

## 🎨 Feedback Visual

### Notificações Inteligentes
```bash
# ~/.config/hypr/scripts/notify-action.sh
# Mostra o que a tecla fez

notify-send -t 1500 -i "$icon" "$title" "$description"

# Exemplos:
# Volume: barra visual
# Workspace: número grande
# App launch: ícone da app
# Mode change: status
```

### Indicadores de Modo
```conf
# Waybar mostra modo atual
"custom/keyboard-mode": {
    "exec": "~/.config/hypr/scripts/show-mode.sh",
    "interval": 1
}

# Modos: NORMAL | RESIZE | COMMAND | INSERT
```

---

## 🚀 Benefícios

1. **Descobribilidade**: SUPER+letra = app óbvia
2. **Consistência**: Mesmas ações em todas apps
3. **Ergonomia**: Teclas mais usadas = mais próximas
4. **Feedback**: Sempre sabe o que aconteceu
5. **Velocidade**: Menos teclas para ações comuns

---

*Implementação gradual recomendada - teste cada mudança por 1 semana*