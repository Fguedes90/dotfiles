# 🎯 Proposta: Sistema de Keybindings Contextuais para Hyprland

## 📋 Visão Geral

Sistema inteligente que detecta a aplicação em foco e apresenta apenas os atalhos relevantes para aquela aplicação específica, melhorando a descoberta e aprendizado de keybindings.

---

## 🔍 Como Funciona

### 1. **Detecção de Aplicação**
```bash
# Hyprland fornece informações da janela ativa
hyprctl activewindow -j

# Retorna JSON com:
{
  "class": "chromium",
  "title": "GitHub - Chromium",
  "pid": 12345,
  "workspace": {"id": 1, "name": "1"},
  ...
}
```

### 2. **Fluxo do Sistema**
```
Usuário pressiona SUPER+F1
         ↓
Script detecta aplicação ativa
         ↓
Busca keybindings da aplicação
         ↓
Apresenta via Wofi/Notificação
```

---

## 💡 Arquitetura Proposta

### 📁 Estrutura de Arquivos
```
~/.config/hypr/
├── scripts/
│   └── keybindings/
│       ├── contextual-help.sh        # Script principal
│       ├── app-detector.sh           # Detecta aplicação ativa
│       └── keybind-presenter.sh      # Apresenta keybindings
├── keybindings/
│   ├── apps/                         # Keybindings por aplicação
│   │   ├── chromium.yaml
│   │   ├── ghostty.yaml
│   │   ├── code.yaml
│   │   ├── nautilus.yaml
│   │   └── default.yaml
│   └── categories/                   # Keybindings por categoria
│       ├── text-editors.yaml
│       ├── browsers.yaml
│       ├── terminals.yaml
│       ├── file-managers.yaml
│       ├── ai-assistants.yaml
│       ├── note-taking.yaml
│       ├── system-monitors.yaml
│       └── dev-tools.yaml
└── conf.d/
    └── contextual-keybindings.conf   # Configuração do keybinding
```

---

## 🛠️ Implementação Detalhada

### 1. **Script Principal** (`contextual-help.sh`)
```bash
#!/bin/bash
# Detecta aplicação ativa e mostra keybindings relevantes

# Obter informações da janela ativa
WINDOW_INFO=$(hyprctl activewindow -j)
APP_CLASS=$(echo "$WINDOW_INFO" | jq -r '.class // "unknown"')
APP_TITLE=$(echo "$WINDOW_INFO" | jq -r '.title // "Unknown"')

# Diretórios de configuração
KEYBINDS_DIR="$HOME/.config/hypr/keybindings"
APPS_DIR="$KEYBINDS_DIR/apps"

# Verificar se existe arquivo específico para a aplicação
if [ -f "$APPS_DIR/${APP_CLASS}.yaml" ]; then
    KEYBINDS_FILE="$APPS_DIR/${APP_CLASS}.yaml"
else
    KEYBINDS_FILE="$APPS_DIR/default.yaml"
fi

# Processar e apresentar keybindings
present_keybindings "$APP_CLASS" "$APP_TITLE" "$KEYBINDS_FILE"
```

### 2. **Formato dos Arquivos de Keybindings** (YAML)
```yaml
# ~/.config/hypr/keybindings/apps/chromium.yaml
application:
  name: "Chromium"
  class: "chromium"
  icon: "🌐"
  
categories:
  - name: "Navegação"
    keybindings:
      - key: "Ctrl+T"
        action: "Nova aba"
      - key: "Ctrl+W"
        action: "Fechar aba"
      - key: "Ctrl+Shift+T"
        action: "Reabrir aba fechada"
      
  - name: "Busca"
    keybindings:
      - key: "Ctrl+F"
        action: "Buscar na página"
      - key: "Ctrl+G"
        action: "Próxima ocorrência"
      
  - name: "Hyprland + Chromium"
    keybindings:
      - key: "Super+W"
        action: "Fechar janela (Hyprland)"
      - key: "Super+F"
        action: "Fullscreen (Hyprland)"
```

### 3. **Apresentador de Keybindings** (`keybind-presenter.sh`)
```bash
#!/bin/bash
# Formata e apresenta keybindings via Wofi

format_keybindings() {
    local yaml_file="$1"
    local app_name="$2"
    
    # Converter YAML para formato legível
    yq eval '.categories[] | 
        "### " + .name + "\n" + 
        (.keybindings[] | "  " + .key + " → " + .action)' \
        "$yaml_file"
}

# Apresentar com Wofi usando tema do Omarchy
show_with_wofi() {
    local content="$1"
    local app_name="$2"
    
    echo "$content" | wofi --dmenu \
        --prompt "Keybindings: $app_name" \
        --width 600 \
        --height 70% \
        --style "$HOME/.local/share/omarchy/default/wofi/search.css"
}
```

---

## 🎨 Funcionalidades Avançadas

### 1. **Detecção Inteligente por Categoria**
```bash
# Se não houver arquivo específico, usar categoria
case "$APP_CLASS" in
    code|vim|nvim|emacs)
        CATEGORY="text-editors"
        ;;
    chromium|chrome|brave|firefox)
        CATEGORY="browsers"
        ;;
    ghostty|kitty|alacritty|wezterm)
        CATEGORY="terminals"
        ;;
    nautilus|thunar|dolphin|nemo)
        CATEGORY="file-managers"
        ;;
    claude-desktop|ChatGPT)
        CATEGORY="ai-assistants"
        ;;
    obsidian)
        CATEGORY="note-taking"
        ;;
    btop|htop|gotop)
        CATEGORY="system-monitors"
        ;;
    lazydocker|docker)
        CATEGORY="dev-tools"
        ;;
    *)
        CATEGORY="default"
        ;;
esac
```

### 2. **Integração com Waybar**
```json
{
    "custom/active-app": {
        "exec": "~/.config/hypr/scripts/keybindings/app-detector.sh",
        "interval": 1,
        "format": "{icon} {class}",
        "format-icons": {
            "chromium": "🌐",
            "ghostty": "👻",
            "code": "💻",
            "nautilus": "📁",
            "claude-desktop": "🤖",
            "obsidian": "🗒️",
            "btop": "📊",
            "lazydocker": "🐳"
        },
        "on-click": "~/.config/hypr/scripts/keybindings/contextual-help.sh",
        "tooltip": true,
        "tooltip-format": "Click for {class} keybindings"
    }
}
```

### 3. **Notificações Inteligentes**
```bash
# Mostrar dica ao trocar de aplicação
monitor_app_changes() {
    local previous_app=""
    
    while true; do
        current_app=$(hyprctl activewindow -j | jq -r '.class')
        
        if [[ "$current_app" != "$previous_app" ]] && [[ -n "$current_app" ]]; then
            # Aplicação mudou, mostrar dica
            show_app_hint "$current_app"
        fi
        
        previous_app="$current_app"
        sleep 0.5
    done
}

show_app_hint() {
    local app="$1"
    notify-send -t 3000 \
        "💡 $app" \
        "Press Super+F1 for keybindings"
}
```

### 4. **Cache e Performance**
```bash
# Cache de keybindings processados
CACHE_DIR="/tmp/hypr-keybinds-cache"
mkdir -p "$CACHE_DIR"

get_cached_keybinds() {
    local app="$1"
    local cache_file="$CACHE_DIR/${app}.cache"
    
    # Verificar se cache existe e é recente (menos de 1 hora)
    if [[ -f "$cache_file" ]] && \
       [[ $(find "$cache_file" -mmin -60 | wc -l) -gt 0 ]]; then
        cat "$cache_file"
        return 0
    fi
    
    return 1
}
```

---

## 🚀 Roadmap de Implementação

### Fase 1: MVP (1 semana) ✅ IMPLEMENTADO!
- [x] Script básico de detecção de aplicação
- [x] Suporte para aplicações principais (Chromium, VS Code, Ghostty, Nautilus, Claude Desktop, btop, lazydocker, Obsidian)
- [x] Integração com Wofi
- [x] Keybinding SUPER+F1

### Fase 2: Melhorias (2 semanas) 🚧 EM PROGRESSO
- [x] Sistema de categorias
- [x] Cache para performance
- [x] Integração com Waybar (script app-detector.sh criado)
- [x] Suporte YAML para fácil edição

### Fase 3: Recursos Avançados (1 mês)
- [ ] Notificações inteligentes
- [ ] Modo "aprendizado" (destaca keybindings não usados)
- [ ] Estatísticas de uso
- [ ] Integração com documentação online

---

## 📝 Exemplos de Uso

### Cenário 1: Desenvolvedor
1. Abre VS Code
2. Pressiona SUPER+F1
3. Vê atalhos específicos do VS Code + atalhos do Hyprland relevantes

### Cenário 2: Navegação Web
1. Usando Chromium
2. Pressiona SUPER+F1
3. Vê atalhos de navegação, abas, busca, DevTools, etc.

### Cenário 3: Gerenciamento de Arquivos
1. Abre Nautilus
2. Pressiona SUPER+F1
3. Vê atalhos de navegação, seleção, operações de arquivo, visualizações

---

## 🔧 Configuração Proposta

### Em `conf.d/contextual-keybindings.conf`:
```bash
# Sistema de Help Contextual
bind = SUPER, F1, exec, ~/.config/hypr/scripts/keybindings/contextual-help.sh
bind = SUPER SHIFT, F1, exec, ~/.config/hypr/scripts/keybindings/edit-app-keybinds.sh

# Monitor de aplicações (opcional)
exec-once = ~/.config/hypr/scripts/keybindings/app-monitor-daemon.sh
```

---

## 💡 Benefícios

1. **Descoberta Facilitada**: Usuários aprendem atalhos conforme usam
2. **Menos Sobrecarga Mental**: Só vê o que é relevante
3. **Customizável**: Fácil adicionar novas aplicações
4. **Integrado**: Usa infraestrutura existente (Wofi, Waybar)
5. **Performático**: Cache e detecção otimizada

---

## 🎯 Alternativas Consideradas

1. **Overlay Permanente**: Pequena janela flutuante com atalhos
   - Prós: Sempre visível
   - Contras: Ocupa espaço na tela

2. **Integração com Mako**: Notificações automáticas
   - Prós: Não intrusivo
   - Contras: Pode ser ignorado

3. **Modo Tutorial**: Guia interativo
   - Prós: Educacional
   - Contras: Complexo de implementar

---

## 📱 Exemplos de Arquivos YAML para Suas Aplicações

### **chromium.yaml**
```yaml
application:
  name: "Chromium"
  class: "chromium"
  icon: "🌐"
  
categories:
  - name: "Navegação"
    keybindings:
      - key: "Ctrl+T"
        action: "Nova aba"
      - key: "Ctrl+Shift+T"
        action: "Reabrir aba fechada"
      - key: "Ctrl+Tab"
        action: "Próxima aba"
      - key: "Ctrl+L"
        action: "Focar barra de endereço"
        
  - name: "Developer Tools"
    keybindings:
      - key: "F12"
        action: "Abrir DevTools"
      - key: "Ctrl+Shift+C"
        action: "Inspecionar elemento"
      - key: "Ctrl+Shift+J"
        action: "Console JavaScript"
```

### **ghostty.yaml**
```yaml
application:
  name: "Ghostty"
  class: "com.mitchellh.ghostty"
  icon: "👻"
  
categories:
  - name: "Janelas e Abas"
    keybindings:
      - key: "Ctrl+Shift+N"
        action: "Nova janela"
      - key: "Ctrl+Shift+T"
        action: "Nova aba"
      - key: "Ctrl+Tab"
        action: "Próxima aba"
        
  - name: "Terminal"
    keybindings:
      - key: "Ctrl+Shift+C"
        action: "Copiar"
      - key: "Ctrl+Shift+V"
        action: "Colar"
      - key: "Ctrl+Shift+F"
        action: "Buscar"
```

### **nautilus.yaml**
```yaml
application:
  name: "Nautilus (Files)"
  class: "org.gnome.Nautilus"
  icon: "📁"
  
categories:
  - name: "Navegação"
    keybindings:
      - key: "Ctrl+L"
        action: "Editar caminho"
      - key: "Alt+Home"
        action: "Ir para Home"
      - key: "Ctrl+H"
        action: "Mostrar arquivos ocultos"
        
  - name: "Visualização"
    keybindings:
      - key: "Ctrl+1"
        action: "Vista de ícones"
      - key: "Ctrl+2"
        action: "Vista de lista"
      - key: "Ctrl+3"
        action: "Vista compacta"
```

### **claude-desktop.yaml**
```yaml
application:
  name: "Claude Desktop"
  class: "Claude"
  icon: "🤖"
  
categories:
  - name: "Conversa"
    keybindings:
      - key: "Ctrl+N"
        action: "Nova conversa"
      - key: "Ctrl+Shift+S"
        action: "Salvar conversa"
      - key: "Ctrl+/"
        action: "Mostrar atalhos"
        
  - name: "Edição"
    keybindings:
      - key: "Ctrl+Enter"
        action: "Enviar mensagem"
      - key: "Shift+Enter"
        action: "Nova linha"
      - key: "Ctrl+K"
        action: "Limpar conversa"
        
  - name: "Navegação"
    keybindings:
      - key: "Ctrl+["
        action: "Conversa anterior"
      - key: "Ctrl+]"
        action: "Próxima conversa"
```

### **obsidian.yaml**
```yaml
application:
  name: "Obsidian"
  class: "obsidian"
  icon: "🗒️"
  
categories:
  - name: "Notas"
    keybindings:
      - key: "Ctrl+N"
        action: "Nova nota"
      - key: "Ctrl+O"
        action: "Abrir nota"
      - key: "Ctrl+P"
        action: "Command palette"
      - key: "Ctrl+E"
        action: "Alternar modo edição/preview"
        
  - name: "Formatação"
    keybindings:
      - key: "Ctrl+B"
        action: "Negrito"
      - key: "Ctrl+I"
        action: "Itálico"
      - key: "Ctrl+K"
        action: "Inserir link"
        
  - name: "Navegação"
    keybindings:
      - key: "Ctrl+Click"
        action: "Abrir link"
      - key: "Ctrl+Tab"
        action: "Próxima aba"
      - key: "Alt+←/→"
        action: "Voltar/Avançar"
```

### **btop.yaml**
```yaml
application:
  name: "btop"
  class: "btop"
  icon: "📊"
  
categories:
  - name: "Visualização"
    keybindings:
      - key: "1/2/3/4"
        action: "Mudar aba (CPU/Mem/Net/Proc)"
      - key: "m"
        action: "Alternar modo de memória"
      - key: "p"
        action: "Alternar modo de processo"
        
  - name: "Processos"
    keybindings:
      - key: "k"
        action: "Kill processo"
      - key: "f"
        action: "Filtrar processos"
      - key: "t"
        action: "Alternar tree view"
      - key: "/"
        action: "Buscar processo"
        
  - name: "Navegação"
    keybindings:
      - key: "↑/↓"
        action: "Navegar lista"
      - key: "Page Up/Down"
        action: "Scroll rápido"
      - key: "Esc/q"
        action: "Sair"
```

### **lazydocker.yaml**
```yaml
application:
  name: "LazyDocker"
  class: "lazydocker"
  icon: "🐳"
  
categories:
  - name: "Navegação"
    keybindings:
      - key: "Tab"
        action: "Próximo painel"
      - key: "h/j/k/l"
        action: "Navegação vim-style"
      - key: "/"
        action: "Buscar"
        
  - name: "Containers"
    keybindings:
      - key: "d"
        action: "Deletar container"
      - key: "r"
        action: "Restart container"
      - key: "s"
        action: "Stop/Start container"
      - key: "Enter"
        action: "Ver logs"
        
  - name: "Ações"
    keybindings:
      - key: "b"
        action: "Bulk actions"
      - key: "x"
        action: "Menu de comandos"
      - key: "?"
        action: "Ajuda"
```

---

## 📚 Referências

- [Hyprland Wiki - IPC](https://wiki.hyprland.org/IPC/)
- [Wofi Documentation](https://hg.sr.ht/~scoopta/wofi)
- [YQ - YAML Processor](https://github.com/mikefarah/yq)
- [Ghostty Documentation](https://github.com/mitchellh/ghostty)
- Scripts existentes em `~/.config/hypr/scripts/`

---

## 🎉 Status da Implementação

### ✅ Implementado
1. **Sistema de detecção de aplicação** (`contextual-help.sh`)
2. **Arquivos YAML para todas as aplicações principais**:
   - chromium.yaml
   - ghostty.yaml
   - nautilus.yaml
   - claude-desktop.yaml
   - obsidian.yaml
   - btop.yaml
   - lazydocker.yaml
   - code.yaml (VS Code)
   - default.yaml (aplicações genéricas)
3. **Sistema de categorias** (browsers.yaml, terminals.yaml)
4. **Cache inteligente** (60 minutos)
5. **Script para integração com Waybar** (`app-detector.sh`)
6. **Keybinding SUPER+F1** configurado em function-keys.conf
7. **Fallback para aplicações sem configuração específica**

### 🔧 Como Usar

1. **Atalho Principal**: Pressione `SUPER+F1` para ver os keybindings da aplicação ativa
2. **Sem Janela Ativa**: Mostra todos os keybindings do sistema
3. **Cache Automático**: Respostas mais rápidas após o primeiro uso

### 📝 Adicionar Nova Aplicação

1. Crie um arquivo YAML em `~/.config/hypr/keybindings/apps/[nome-app].yaml`
2. Use o formato padrão dos outros arquivos
3. O sistema detectará automaticamente

### ⚠️ Nota sobre YQ

O sistema funciona sem `yq`, mas a instalação é recomendada para melhor formatação:
```bash
# Arch Linux
sudo pacman -S yq

# Ou via pip
pip install yq
```