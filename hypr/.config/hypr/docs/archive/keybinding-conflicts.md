# Conflitos de Keybindings - Omarchy vs Custom

## 🔴 Conflitos Críticos que Precisam Resolução

### 1. **SUPER + V**
- **Omarchy**: togglefloating (alternar janela flutuante)
- **Custom**: Mostrar notificação de volume
- **Sugestão**: Manter Omarchy, mover volume para SUPER+ALT+V

### 2. **SUPER + P**
- **Omarchy**: pseudo (pseudo tiling)
- **Custom**: pin (fixar janela)
- **Sugestão**: Mover pin para SUPER+SHIFT+P

### 3. **SUPER + K**
- **Omarchy**: omarchy-show-keybindings 
- **Custom**: movefocus up (navegação vim)
- **Conflito**: Você tem 2 sistemas de keybindings!
- **Sugestão**: Usar SUPER+F1 para keybindings, manter K para navegação

### 4. **SUPER + J**
- **Omarchy**: togglesplit
- **Custom**: movefocus down (navegação vim)
- **Sugestão**: Mover togglesplit para SUPER+S

### 5. **SUPER + W**
- **Omarchy**: killactive (fechar janela)
- **Custom**: Browser (já comentado por conflito)
- **Status**: ✅ Já resolvido

### 6. **SUPER + B**
- **Custom**: Toggle waybar E notificação de brilho (duplicado!)
- **Sugestão**: Remover notificação de brilho

### 7. **SUPER + M**
- **Omarchy**: Não usado
- **Custom**: layoutmsg swapwithmaster E spotify (conflito interno!)
- **Sugestão**: Resolver duplicação

### 8. **Navegação de Workspace**
- **Omarchy**: Suporta 10 workspaces (1-0)
- **Custom**: Limitado a 5 workspaces
- **Impacto**: Workspaces 6-10 não acessíveis

### 9. **SUPER + SPACE**
- **Omarchy**: wofi --show drun
- **Custom**: rofi -show drun
- **Sugestão**: Escolher um launcher

### 10. **Screenshots**
- **Omarchy**: hyprshot (Print, Shift+Print, Ctrl+Print)
- **Custom**: grimblast (mesmas teclas)
- **Sugestão**: Escolher uma ferramenta

## 🟡 Duplicações Internas (no Custom)

1. **SUPER + SHIFT + grave**
   - movetoworkspace special
   - movecurrentworkspacetomonitor +1
   
2. **SUPER + grave**
   - togglespecialworkspace
   - focusmonitor +1

3. **XF86Display**
   - Definido 2x para clamshell auto

## 🟢 Keybindings Únicas do Omarchy (sem conflito)

- **SUPER + ,**: Controles de notificação (dismiss)
- **SUPER + ESCAPE**: Power menu
- **SUPER + CTRL + I**: Toggle idle
- **SUPER + CTRL + SPACE**: Próximo wallpaper
- **SUPER + SHIFT + CTRL + SPACE**: Próximo tema

## 📋 Ações Recomendadas

1. Decidir entre navegação por setas (Omarchy) ou HJKL (vim-style)
2. Unificar ferramentas: wofi vs rofi, hyprshot vs grimblast
3. Resolver duplicações internas
4. Documentar overrides intencionais