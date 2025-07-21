# 📖 Referência Completa de Keybindings

**Sistema:** Hyprland + Omarchy + Custom  
**Última Atualização:** 2025-07-21

---

## 🎯 Aplicações (Launch Apps)

### Principal (SUPER + Letra)
| Keybind | Aplicação | Descrição |
|---------|-----------|-----------|
| `SUPER+B` | chromium | 🌐 Browser |
| `SUPER+C` | gnome-calculator | 🖩 Calculator |
| `SUPER+D` | discord | 💬 Discord |
| `SUPER+E` | code | 📝 VS Code |
| `SUPER+F` | nautilus | 📁 Files |
| `SUPER+G` | steam | 🎮 Games |
| `SUPER+M` | spotify | 🎵 Music |
| `SUPER+N` | obsidian | 📔 Notes |
| `SUPER+O` | wofi --show drun | 🚪 Quick Open |
| `SUPER+T` | ghostty | 💻 Terminal |

### Secundário (SUPER+SHIFT + Letra)
| Keybind | Aplicação | Descrição |
|---------|-----------|-----------|
| `SUPER+SHIFT+B` | brave | 🦁 Brave Browser |
| `SUPER+SHIFT+C` | claude-desktop | 🤖 Claude |
| `SUPER+SHIFT+E` | thunderbird | 📧 Email |
| `SUPER+SHIFT+L` | lazydocker | 🐳 LazyDocker |
| `SUPER+SHIFT+M` | btop | 📊 System Monitor |

---

## 🪟 Controle de Janelas

### Básico
| Keybind | Ação | Descrição |
|---------|------|-----------|
| `SUPER+Q` | killactive | Fechar janela |
| `SUPER+SHIFT+Q` | exit | Sair do Hyprland |
| `SUPER+V` | togglefloating | Alternar flutuante |
| `SUPER+P` | pseudo | Pseudo tile |
| `SUPER+J` | togglesplit | Alternar split |
| `SUPER+SPACE` | togglefloating | Alternar flutuante (alt) |

### Fullscreen e Grupos
| Keybind | Ação | Descrição |
|---------|------|-----------|
| `SUPER+F` | fullscreen | Tela cheia (conflito com Files) |
| `SUPER+SHIFT+F` | fakefullscreen | Fake fullscreen |
| `SUPER+G` | togglegroup | Alternar grupo (conflito com Steam) |
| `SUPER+TAB` | changegroupactive | Próxima janela no grupo |

### Navegação (Foco)
| Keybind | Ação | Descrição |
|---------|------|-----------|
| `SUPER+H` | movefocus, l | Foco à esquerda |
| `SUPER+J` | movefocus, d | Foco abaixo |
| `SUPER+K` | movefocus, u | Foco acima |
| `SUPER+L` | movefocus, r | Foco à direita |
| `SUPER+←↓↑→` | movefocus | Foco direções |
| `ALT+TAB` | cyclenext | Próxima janela |

### Mover Janelas
| Keybind | Ação | Descrição |
|---------|------|-----------|
| `SUPER+SHIFT+H/J/K/L` | movewindow | Mover janela |
| `SUPER+SHIFT+←↓↑→` | movewindow | Mover janela |
| `SUPER+MOUSE` | movewindow | Arrastar janela |

### Redimensionar
| Keybind | Ação | Descrição |
|---------|------|-----------|
| `SUPER+R` | submap, resize | Entrar modo resize |
| `SUPER+CTRL+H/J/K/L` | resizeactive | Redimensionar direto |
| `SUPER+CTRL+←↓↑→` | resizeactive | Redimensionar direto |

---

## 🔢 Workspaces

### Navegação Direta
| Keybind | Ação | Descrição |
|---------|------|-----------|
| `SUPER+1-9` | workspace, N | Ir para workspace N |
| `SUPER+0` | workspace, 10 | Ir para workspace 10 |
| `SUPER+grave` | workspace, previous | Última usada |
| `SUPER+comma` | workspace, -1 | Workspace anterior |
| `SUPER+period` | workspace, +1 | Próxima workspace |

### Mover Janela
| Keybind | Ação | Descrição |
|---------|------|-----------|
| `SUPER+SHIFT+1-9` | movetoworkspace, N | Mover para workspace N |
| `SUPER+SHIFT+0` | movetoworkspace, 10 | Mover para workspace 10 |
| `SUPER+CTRL+1-5` | movetoworkspacesilent | Mover sem seguir |

### Scroll
| Keybind | Ação | Descrição |
|---------|------|-----------|
| `SUPER+SCROLL↑` | workspace, e+1 | Próxima workspace |
| `SUPER+SCROLL↓` | workspace, e-1 | Workspace anterior |

---

## ⌨️ Teclas de Função

### F1-F12 Direto
| Keybind | Ação | Descrição |
|---------|------|-----------|
| `F1` | Wiki Hyprland | Ajuda online |
| `F2` | Keyboard backlight ↓ | Diminuir luz teclado |
| `F3` | Keyboard backlight ↑ | Aumentar luz teclado |
| `F4` | AURA LED mode | Modo LED |
| `F5` | Brightness ↓ | Diminuir brilho |
| `F6` | Brightness ↑ | Aumentar brilho |
| `F7` | (reservado) | Display switch |
| `F8` | wdisplays | Configurar displays |
| `F9` | Touchpad toggle | Alternar touchpad |
| `F10` | Mic mute | Mutar microfone |

### SUPER + F1-F12
| Keybind | Ação | Descrição |
|---------|------|-----------|
| `SUPER+F1` | Contextual help | Ajuda contextual |
| `SUPER+F2` | Color picker | Seletor de cores |
| `SUPER+F3` | LED mode | Modo LED ASUS |
| `SUPER+F4` | Performance profile | Perfil performance |
| `SUPER+F5` | Night light ON | Luz noturna |
| `SUPER+SHIFT+F5` | Night light OFF | Desligar luz noturna |
| `SUPER+F6` | Screenshot OCR | OCR de screenshot |
| `SUPER+F7` | Display auto | Auto-detectar display |
| `SUPER+F8` | WiFi menu | Menu WiFi |
| `SUPER+F9` | Bluetooth menu | Menu Bluetooth |
| `SUPER+F10` | pavucontrol | Controle de áudio |
| `SUPER+F11` | Network settings | Configurações de rede |
| `SUPER+F12` | System monitor | Monitor do sistema |

---

## 🎮 Mídia e Volume

### Controle de Volume
| Keybind | Ação | Descrição |
|---------|------|-----------|
| `XF86AudioRaiseVolume` | Volume +5% | Aumentar volume |
| `XF86AudioLowerVolume` | Volume -5% | Diminuir volume |
| `XF86AudioMute` | Toggle mute | Mutar/Desmutar |
| `SUPER+=` | Volume +5% | Aumentar (alt) |
| `SUPER+-` | Volume -5% | Diminuir (alt) |
| `SUPER+BackSpace` | Toggle mute | Mutar (alt) |

### Controle de Mídia
| Keybind | Ação | Descrição |
|---------|------|-----------|
| `XF86AudioPlay` | play-pause | Play/Pause |
| `XF86AudioNext` | next | Próxima faixa |
| `XF86AudioPrev` | previous | Faixa anterior |
| `SUPER+\` | play-pause | Play/Pause (alt) |
| `SUPER+]` | next | Próxima (alt) |
| `SUPER+[` | previous | Anterior (alt) |

---

## 🎯 Ações Inteligentes

### Smart Actions
| Keybind | Ação | Descrição |
|---------|------|-----------|
| `SUPER+Return` | Smart terminal | Terminal ou split |
| `SUPER+S` | Smart save | Salvar contextual |
| `SUPER+/` | Smart find | Buscar contextual |
| `SUPER+ALT+O` | Smart open | Abrir contextual |
| `SUPER+ALT+Q` | Smart close | Fechar contextual |

### Ajuda e Utilitários
| Keybind | Ação | Descrição |
|---------|------|-----------|
| `SUPER+K` | Show keybindings | Mostrar todos atalhos |
| `SUPER+SHIFT+/` | Contextual help | Ajuda da app atual |
| `SUPER+.` | Quick actions | Menu ações rápidas |
| `SUPER+:` | Command mode | Modo comando |

---

## 📸 Screenshots

| Keybind | Ação | Descrição |
|---------|------|-----------|
| `Print` | Copy area | Copiar área |
| `CTRL+Print` | Copy window | Copiar janela |
| `ALT+Print` | Copy screen | Copiar tela toda |
| `SUPER+Print` | Save area | Salvar área |

---

## 🎨 Utilitários

| Keybind | Ação | Descrição |
|---------|------|-----------|
| `SUPER+I` | Color picker | Seletor de cor |
| `SUPER+;` | Emoji picker | Seletor emoji |
| `SUPER+V` | Clipboard | Histórico clipboard |
| `SUPER+Z` | Quick note | Nota rápida |

---

## 🔒 Sistema

### Controle do Sistema
| Keybind | Ação | Descrição |
|---------|------|-----------|
| `SUPER+Escape` | Power menu | Menu power |
| `SUPER+L` | Lock screen | Bloquear tela |
| `SUPER+SHIFT+R` | Reload config | Recarregar config |
| `SUPER+CTRL+ALT+Q` | Force kill | Forçar fechar |
| `CTRL+ALT+T` | Emergency terminal | Terminal emergência |

### Modos de Display
| Keybind | Ação | Descrição |
|---------|------|-----------|
| `SUPER+CTRL+M` | Dual monitor | Dois monitores |
| `SUPER+CTRL+C` | Clamshell | Modo clamshell |
| `SUPER+CTRL+S` | Single | Monitor único |

---

## ⌨️ Modos Especiais

### Resize Mode (SUPER+R)
| Keybind | Ação | Descrição |
|---------|------|-----------|
| `H/←` | Resize -50 0 | Diminuir largura |
| `L/→` | Resize 50 0 | Aumentar largura |
| `J/↓` | Resize 0 50 | Aumentar altura |
| `K/↑` | Resize 0 -50 | Diminuir altura |
| `SHIFT+...` | Resize ±10 | Ajuste fino |
| `1` | 640x480 | Tamanho pequeno |
| `2` | 1280x720 | HD |
| `3` | 1920x1080 | Full HD |
| `M` | 100% 100% | Maximizar |
| `ESC/Q` | Exit | Sair do modo |

---

## 🚫 Keybindings Reservados

### Nunca Sobrescrever
- `CTRL+ALT+Delete` - Sistema
- `CTRL+ALT+F1-F7` - TTY
- `ALT+F4` - Fechar (universal)
- `Print Screen` - Screenshot

### Use com Cuidado
- `SUPER+CTRL+...` - Sistema/Hardware
- `CTRL+ALT+...` - Pode conflitar
- `XF86*` - Teclas de hardware

---

*Use `SUPER+K` para ver esta lista interativamente*