# ⌨️ Workflow 100% Teclado - Guia Completo

## 🎯 Filosofia: Zero Mouse, Máxima Produtividade

### Princípios Fundamentais
1. **Toda ação deve ser acessível via teclado**
2. **Atalhos devem formar "frases" lógicas** (SUPER+W = Window close)
3. **Proximidade ergonômica** (ações frequentes = teclas próximas)
4. **Feedback imediato** (visual/auditivo para confirmar ação)
5. **Navegação hierárquica** (geral → específico)

---

## 🚀 Fluxo de Trabalho Completo

### 1. Boot → Desktop (Sem Mouse)
```yaml
Login:
  - Digite senha + Enter
  - Hyprland inicia automaticamente

Primeira Ação:
  SUPER + Return    → Abre terminal
  SUPER + Space     → Abre launcher
  SUPER + 1-9       → Vai direto para workspace
```

### 2. Lançar Aplicações (Intuitivo)
```yaml
Launcher Rápido:
  SUPER + Space     → Wofi launcher
  - Digite 3 letras → Enter
  - ESC para cancelar

Atalhos Diretos (mnemônicos):
  SUPER + W         → Web browser (W = Web)
  SUPER + E         → Editor (E = Editor)
  SUPER + F         → File manager (F = Files)
  SUPER + T         → Terminal (T = Terminal)
  SUPER + M         → Music (M = Music)
  SUPER + C         → Calculator (C = Calc)
  SUPER + S         → Settings (S = Settings)
```

### 3. Navegação de Janelas (Sem Mouse!)
```yaml
Foco:
  SUPER + H/J/K/L   → Mover foco (vim-style)
  SUPER + ←/↓/↑/→   → Mover foco (arrows)
  SUPER + Tab       → Cycle janelas
  ALT + Tab         → App switcher visual

Mover:
  SUPER + Shift + H/J/K/L   → Mover janela
  SUPER + Shift + 1-9       → Mover para workspace

Redimensionar:
  SUPER + R                 → Modo resize
  - H/J/K/L para ajustar
  - ESC para sair

Layout:
  SUPER + V         → Toggle floating
  SUPER + F         → Fullscreen
  SUPER + P         → Pseudo tile
  SUPER + G         → Agrupar janelas
```

### 4. Navegação Dentro de Apps
```yaml
Universal:
  Tab               → Próximo elemento
  Shift + Tab       → Element anterior
  Enter             → Ativar/Confirmar
  Space             → Toggle/Select
  ESC               → Cancelar/Voltar

Menus:
  Alt + [letra]     → Acessar menu
  ↓                 → Navegar items
  →                 → Submenu
  Enter             → Selecionar

Diálogos:
  Tab               → Próximo campo
  Alt + [letra]     → Botão direto
  Enter             → OK/Confirmar
  ESC               → Cancelar
```

---

## 🎨 Keybindings Intuitivos por Contexto

### Sistema/Window Manager
```yaml
# Mnemônicos claros
SUPER + Q         → Quit (fechar janela)
SUPER + A         → Apps (mostrar todas)
SUPER + D         → Desktop (mostrar)
SUPER + L         → Lock screen
SUPER + X         → eXit menu (logout)
SUPER + R         → Resize mode
SUPER + N         → Notifications
SUPER + /         → Help (mostrar keybinds)
```

### Workspaces (Número = Posição)
```yaml
SUPER + 1-9       → Ir para workspace N
SUPER + 0         → Workspace 10
SUPER + -         → Workspace anterior
SUPER + =         → Próximo workspace

SUPER + Shift + 1-9   → Mover janela para N
SUPER + Ctrl + 1-9    → Mover E seguir para N
```

### Aplicações Quick Launch
```yaml
# Primeira letra quando possível
SUPER + B         → Browser
SUPER + C         → Calculator  
SUPER + E         → Editor (Code)
SUPER + F         → File manager
SUPER + M         → Music player
SUPER + S         → Settings
SUPER + T         → Terminal
SUPER + W         → Web (alternativa)

# Segunda letra para conflitos
SUPER + Shift + M → Mail
SUPER + Shift + C → Chat
```

---

## 🔄 Fluxos Completos Sem Mouse

### Fluxo 1: Pesquisa Web
```
1. SUPER + B              → Abre browser
2. Ctrl + L               → Foco na barra
3. Digite busca           → Enter
4. Tab (múltiplos)        → Navegar links
5. Enter                  → Abrir link
6. Ctrl + W               → Fechar aba
7. SUPER + Q              → Fechar browser
```

### Fluxo 2: Editar Código
```
1. SUPER + E              → Abre editor
2. Ctrl + P               → Quick open
3. Digite arquivo         → Enter
4. Ctrl + G               → Ir para linha
5. Digite número          → Enter
6. Editar...
7. Ctrl + S               → Salvar
8. Alt + ←                → Voltar
```

### Fluxo 3: Gerenciar Arquivos
```
1. SUPER + F              → File manager
2. / ou Ctrl + L          → Digite caminho
3. Tab                    → Navegar painéis
4. ↑/↓                    → Selecionar arquivo
5. Space                  → Marcar múltiplos
6. Ctrl + C/X             → Copiar/Cortar
7. Ctrl + V               → Colar
8. F2                     → Renomear
```

### Fluxo 4: Multitasking
```
1. SUPER + 1              → Workspace 1 (browser)
2. SUPER + 2              → Workspace 2 (editor)
3. SUPER + 3              → Workspace 3 (terminal)
4. SUPER + Tab            → Quick switch
5. SUPER + Shift + 2      → Mover janela para WS2
6. SUPER + G              → Agrupar janelas
7. SUPER + J/K            → Navegar no grupo
```

---

## 🛠️ Configurações Recomendadas

### 1. Habilitar Vim-keys Everywhere
```conf
# ~/.config/hypr/conf.d/vim-navigation.conf
# Navegação consistente estilo Vim

# Foco
bind = SUPER, h, movefocus, l
bind = SUPER, j, movefocus, d  
bind = SUPER, k, movefocus, u
bind = SUPER, l, movefocus, r

# Mover
bind = SUPER SHIFT, h, movewindow, l
bind = SUPER SHIFT, j, movewindow, d
bind = SUPER SHIFT, k, movewindow, u  
bind = SUPER SHIFT, l, movewindow, r

# Resize
bind = SUPER CTRL, h, resizeactive, -50 0
bind = SUPER CTRL, j, resizeactive, 0 50
bind = SUPER CTRL, k, resizeactive, 0 -50
bind = SUPER CTRL, l, resizeactive, 50 0
```

### 2. Quick Actions Menu
```conf
# Menu rápido de ações comuns
bind = SUPER, semicolon, exec, ~/.config/hypr/scripts/quick-actions-menu.sh

# Script mostra:
# - Screenshot
# - Color picker  
# - Emoji picker
# - Calculator
# - etc.
```

### 3. Smart Tab Navigation
```conf
# Tab inteligente que detecta contexto
bind = ALT, Tab, exec, ~/.config/hypr/scripts/smart-tab.sh

# Se uma janela: cycle windows
# Se grupo: cycle no grupo
# Se workspace vazio: lista workspaces
```

### 4. Command Palette Universal
```conf
# SUPER + P para palette em qualquer lugar
bind = SUPER, P, exec, ~/.config/hypr/scripts/command-palette.sh

# Oferece:
# - Comandos do sistema
# - Ações da app atual
# - Scripts customizados
# - Configurações rápidas
```

---

## 📊 Cobertura de Ações

### ✅ 100% Cobertura Alcançada
- [x] Abrir qualquer aplicação
- [x] Navegar entre janelas
- [x] Mover/redimensionar janelas
- [x] Gerenciar workspaces
- [x] Controlar mídia
- [x] Screenshots
- [x] Gerenciar arquivos
- [x] Editar texto
- [x] Navegar web
- [x] Controlar sistema

### 🎯 Métricas de Eficiência
| Ação | Mouse | Teclado | Economia |
|------|-------|---------|----------|
| Abrir app | 3 clicks | 3 teclas | 66% |
| Mudar janela | 1 click | 2 teclas | Similar |
| Mover janela | Drag | 3 teclas | 80% |
| Screenshot área | 4 clicks | 3 teclas | 25% |

---

## 🧠 Dicas de Memorização

### 1. Pense em "Frases"
```
SUPER + W = "Window Webrowser"
SUPER + F = "Fullscreen Files"  
SUPER + T = "Terminal Time"
SUPER + Q = "Quit Quickly"
```

### 2. Agrupe por Função
```
Navegação: H/J/K/L (vim)
Números: 1-9 (workspaces)
Letras: Apps e ações
F-keys: Hardware/Sistema
```

### 3. Pratique Fluxos
- Manhã: Abrir apps sem mouse
- Tarde: Navegar só com teclado
- Noite: Fechar tudo via teclado

### 4. Use Notificações
```conf
# Feedback visual para aprendizado
bind = SUPER, W, exec, notify-send "🌐 Browser" "SUPER+W abre navegador" && chromium
```

---

## 🚀 Próximos Passos

1. **Semana 1**: Memorize navegação básica (SUPER + HJKL)
2. **Semana 2**: Pratique lançar apps (SUPER + letra)
3. **Semana 3**: Domine workspaces (SUPER + números)
4. **Semana 4**: Fluxos completos sem tocar no mouse

---

*Meta: 0 cliques por dia - 100% keyboard productivity* 🎯