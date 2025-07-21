# ⚡ Configuração Ultimate - 100% Teclado

## 🎯 Objetivo: Zero Mouse, Máxima Velocidade

### Princípios Aplicados
1. **Mnemônico**: Primeira letra = Função
2. **Hierárquico**: Geral → Específico  
3. **Ergonômico**: Ações frequentes = Teclas fáceis
4. **Consistente**: Mesma ação = Mesma tecla
5. **Descobrível**: Ajuda sempre disponível

---

## 🚀 Configuração Recomendada Completa

### ~/.config/hypr/conf.d/ultimate-keyboard.conf

```conf
# =============================================
# ULTIMATE KEYBOARD CONFIGURATION
# =============================================
# Zero mouse, maximum productivity
# Todas as ações acessíveis via teclado

# =============================================
# CORE SYSTEM - SUPER (Most Important)
# =============================================

# --- Essential Actions ---
bind = SUPER, Return, exec, ghostty                    # Terminal
bind = SUPER, Space, exec, wofi --show drun           # Launcher  
bind = SUPER, Q, killactive                            # Quit window
bind = SUPER, Escape, exec, wlogout                    # Exit menu
bind = SUPER, L, exec, swaylock                        # Lock
bind = SUPER, slash, exec, $HOME/.config/hypr/scripts/keybindings/contextual-help.sh  # ? = Help

# --- Window Control ---
bind = SUPER, F, fullscreen                            # Fullscreen
bind = SUPER SHIFT, F, fakefullscreen                  # Fake fullscreen
bind = SUPER, V, togglefloating                        # Float toggle
bind = SUPER, P, pseudo                                # Pseudo tile
bind = SUPER, J, togglesplit                           # Split toggle
bind = SUPER, G, togglegroup                           # Group windows
bind = SUPER SHIFT, G, moveoutofgroup                  # Ungroup

# --- Focus Movement (Intuitive) ---
# Arrow keys for beginners
bind = SUPER, left, movefocus, l
bind = SUPER, down, movefocus, d
bind = SUPER, up, movefocus, u
bind = SUPER, right, movefocus, r

# Vim keys for power users
bind = SUPER, h, movefocus, l
bind = SUPER, j, movefocus, d
bind = SUPER, k, movefocus, u
bind = SUPER, l, movefocus, r

# Tab cycling
bind = SUPER, Tab, cyclenext
bind = SUPER SHIFT, Tab, cyclenext, prev
bind = ALT, Tab, exec, ~/.config/hypr/scripts/window-switcher.sh

# --- Window Movement ---
bind = SUPER SHIFT, left, movewindow, l
bind = SUPER SHIFT, down, movewindow, d
bind = SUPER SHIFT, up, movewindow, u
bind = SUPER SHIFT, right, movewindow, r

bind = SUPER SHIFT, h, movewindow, l
bind = SUPER SHIFT, j, movewindow, d
bind = SUPER SHIFT, k, movewindow, u
bind = SUPER SHIFT, l, movewindow, r

# --- Window Resize ---
bind = SUPER, R, submap, resize
submap = resize
  # Arrow keys
  bind = , left, resizeactive, -50 0
  bind = , down, resizeactive, 0 50
  bind = , up, resizeactive, 0 -50
  bind = , right, resizeactive, 50 0
  
  # Vim keys
  bind = , h, resizeactive, -50 0
  bind = , j, resizeactive, 0 50
  bind = , k, resizeactive, 0 -50
  bind = , l, resizeactive, 50 0
  
  # Fine control with shift
  bind = SHIFT, left, resizeactive, -10 0
  bind = SHIFT, down, resizeactive, 0 10
  bind = SHIFT, up, resizeactive, 0 -10
  bind = SHIFT, right, resizeactive, 10 0
  
  # Preset sizes
  bind = , 1, resizeactive, exact 640 480     # Small
  bind = , 2, resizeactive, exact 1280 720    # HD
  bind = , 3, resizeactive, exact 1920 1080   # Full HD
  bind = , m, resizeactive, exact 100% 100%   # Maximize
  
  # Exit resize mode
  bind = , escape, submap, reset
  bind = , Return, submap, reset
  bind = , q, submap, reset
submap = reset

# =============================================
# WORKSPACE NAVIGATION - Numbers
# =============================================

# Direct workspace access
bind = SUPER, 1, workspace, 1
bind = SUPER, 2, workspace, 2
bind = SUPER, 3, workspace, 3
bind = SUPER, 4, workspace, 4
bind = SUPER, 5, workspace, 5
bind = SUPER, 6, workspace, 6
bind = SUPER, 7, workspace, 7
bind = SUPER, 8, workspace, 8
bind = SUPER, 9, workspace, 9
bind = SUPER, 0, workspace, 10

# Relative navigation
bind = SUPER, comma, workspace, -1             # Previous
bind = SUPER, period, workspace, +1            # Next
bind = SUPER, grave, workspace, previous       # Last used

# Move window to workspace
bind = SUPER SHIFT, 1, movetoworkspace, 1
bind = SUPER SHIFT, 2, movetoworkspace, 2
bind = SUPER SHIFT, 3, movetoworkspace, 3
bind = SUPER SHIFT, 4, movetoworkspace, 4
bind = SUPER SHIFT, 5, movetoworkspace, 5
bind = SUPER SHIFT, 6, movetoworkspace, 6
bind = SUPER SHIFT, 7, movetoworkspace, 7
bind = SUPER SHIFT, 8, movetoworkspace, 8
bind = SUPER SHIFT, 9, movetoworkspace, 9
bind = SUPER SHIFT, 0, movetoworkspace, 10

# Move and follow
bind = SUPER CTRL, 1, movetoworkspacesilent, 1
bind = SUPER CTRL, 2, movetoworkspacesilent, 2
bind = SUPER CTRL, 3, movetoworkspacesilent, 3
bind = SUPER CTRL, 4, movetoworkspacesilent, 4
bind = SUPER CTRL, 5, movetoworkspacesilent, 5

# =============================================
# APPLICATION SHORTCUTS - Mnemonic
# =============================================

# Primary apps (SUPER + First Letter)
bind = SUPER, B, exec, chromium                        # Browser
bind = SUPER, C, exec, gnome-calculator                # Calculator
bind = SUPER, D, exec, discord                         # Discord
bind = SUPER, E, exec, code                            # Editor (VS Code)
bind = SUPER, F, exec, nautilus                        # Files
bind = SUPER, M, exec, spotify                         # Music
bind = SUPER, N, exec, obsidian                        # Notes
bind = SUPER, O, exec, ~/.config/hypr/scripts/quick-open.sh  # Open (smart)
bind = SUPER, S, exec, gnome-control-center           # Settings
bind = SUPER, T, exec, ghostty                         # Terminal (duplicate)
bind = SUPER, W, exec, chromium                        # Web (duplicate)

# Secondary apps (SUPER + SHIFT + Letter)
bind = SUPER SHIFT, B, exec, brave                     # Brave browser
bind = SUPER SHIFT, C, exec, claude-desktop            # Claude
bind = SUPER SHIFT, E, exec, emacs                     # Emacs
bind = SUPER SHIFT, M, exec, thunderbird              # Mail
bind = SUPER SHIFT, S, exec, steam                     # Steam
bind = SUPER SHIFT, T, exec, btop                      # Task manager

# =============================================
# QUICK ACTIONS - Productivity
# =============================================

# Screenshots (mnemonic: Print)
bind = , Print, exec, grimblast --notify copy area
bind = CTRL, Print, exec, grimblast --notify copy active
bind = ALT, Print, exec, grimblast --notify copy screen
bind = SUPER, Print, exec, grimblast --notify save area ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png

# Clipboard manager
bind = SUPER, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy

# Color picker
bind = SUPER, I, exec, hyprpicker -a                  # I = Ink/Color

# Emoji picker  
bind = SUPER, semicolon, exec, wofi-emoji             # ; = :) emoji

# Quick notes
bind = SUPER, Z, exec, ~/.config/hypr/scripts/quick-note.sh  # Z = Zettelkasten

# =============================================
# MEDIA CONTROLS - Universal
# =============================================

# Volume
bind = , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

# Alternative volume (no special keys)
bind = SUPER, equal, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+     # + key
bind = SUPER, minus, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-             # - key
bind = SUPER, BackSpace, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle        # Mute

# Media playback
bind = , XF86AudioPlay, exec, playerctl play-pause
bind = , XF86AudioNext, exec, playerctl next
bind = , XF86AudioPrev, exec, playerctl previous

# Alternative media (no special keys)
bind = SUPER, bracketright, exec, playerctl next      # ] = next
bind = SUPER, bracketleft, exec, playerctl previous   # [ = prev
bind = SUPER, backslash, exec, playerctl play-pause   # \ = play/pause

# =============================================
# SYSTEM CONTROL - Function Keys
# =============================================

# Brightness
bind = , XF86MonBrightnessUp, exec, brightnessctl set 5%+
bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%-

# Alternative brightness
bind = SUPER, F6, exec, brightnessctl set 5%+
bind = SUPER, F5, exec, brightnessctl set 5%-

# Display management
bind = SUPER, F7, exec, wdisplays                     # Display config
bind = SUPER, F8, exec, ~/.config/hypr/scripts/display/clamshell.sh auto

# Network
bind = SUPER, F9, exec, ~/.config/hypr/scripts/wifi-menu.sh
bind = SUPER SHIFT, F9, exec, ~/.config/hypr/scripts/bluetooth-menu.sh

# System
bind = SUPER, F10, exec, pavucontrol                  # Audio control
bind = SUPER, F11, exec, ~/.config/hypr/scripts/performance-mode.sh
bind = SUPER, F12, exec, ~/.config/hypr/scripts/system-info.sh

# =============================================
# SPECIAL MODES - Advanced
# =============================================

# Command mode (like Vim)
bind = SUPER, colon, exec, ~/.config/hypr/scripts/command-mode.sh

# Quick launcher mode
bind = SUPER, period, submap, launcher
submap = launcher
  bind = , b, exec, chromium
  bind = , b, submap, reset
  
  bind = , c, exec, code
  bind = , c, submap, reset
  
  bind = , d, exec, discord
  bind = , d, submap, reset
  
  bind = , f, exec, nautilus
  bind = , f, submap, reset
  
  bind = , g, exec, gimp
  bind = , g, submap, reset
  
  bind = , m, exec, spotify
  bind = , m, submap, reset
  
  bind = , n, exec, obsidian
  bind = , n, submap, reset
  
  bind = , s, exec, steam
  bind = , s, submap, reset
  
  bind = , t, exec, ghostty
  bind = , t, submap, reset
  
  bind = , escape, submap, reset
submap = reset

# =============================================
# EMERGENCY SHORTCUTS
# =============================================

# Force quit
bind = SUPER CTRL ALT, Q, exec, hyprctl kill

# Reload config
bind = SUPER CTRL, R, exec, hyprctl reload

# Emergency terminal
bind = CTRL ALT, T, exec, foot  # Fallback terminal

# =============================================
# ACCESSIBILITY
# =============================================

# Zoom
bind = SUPER, KP_Add, exec, hyprctl keyword misc:cursor_zoom_factor "$(hyprctl getoption misc:cursor_zoom_factor | grep -oP 'float: \K[0-9.]+' | awk '{print $1 + 0.1}')"
bind = SUPER, KP_Subtract, exec, hyprctl keyword misc:cursor_zoom_factor "$(hyprctl getoption misc:cursor_zoom_factor | grep -oP 'float: \K[0-9.]+' | awk '{print $1 - 0.1}')"

# High contrast
bind = SUPER CTRL, H, exec, ~/.config/hypr/scripts/toggle-high-contrast.sh

# =============================================
# GAMING MODE
# =============================================

# Toggle gaming mode (disables some shortcuts)
bind = SUPER, F1, exec, ~/.config/hypr/scripts/gaming-mode.sh
```

---

## 📋 Cheatsheet Rápido

### Essenciais (Memorize Primeiro)
```
SUPER + Return     → Terminal
SUPER + Space      → Launcher
SUPER + Q          → Fechar janela
SUPER + [1-9]      → Workspaces
SUPER + Tab        → Alternar janelas
SUPER + /          → Ajuda
```

### Apps (Primeira Letra)
```
SUPER + B          → Browser
SUPER + E          → Editor
SUPER + F          → Files
SUPER + M          → Music
SUPER + N          → Notes
SUPER + T          → Terminal
```

### Navegação
```
SUPER + [hjkl]     → Mover foco
SUPER + [arrows]   → Mover foco
SUPER + R          → Resize mode
ALT + Tab          → Window switcher
```

---

## 🚀 Scripts de Suporte Necessários

1. **window-switcher.sh** - Switcher visual estilo Alt+Tab
2. **quick-open.sh** - Abre arquivo/URL/app baseado em contexto
3. **quick-note.sh** - Cria nota rápida com timestamp
4. **command-mode.sh** - Modo comando estilo Vim
5. **gaming-mode.sh** - Desativa shortcuts para jogos
6. **wifi-menu.sh** - Menu de WiFi via wofi
7. **bluetooth-menu.sh** - Menu Bluetooth via wofi

---

*Esta configuração elimina 100% a necessidade do mouse para operações diárias*