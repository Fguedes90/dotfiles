# ⌨️ Workflow 100% Teclado

**Meta:** Eliminar completamente a necessidade do mouse  
**Filosofia:** Zero mouse, máxima produtividade

---

## 🎯 Conceitos Fundamentais

### 1. Hierarquia de Teclas
- **SUPER**: Controle do sistema e janelas
- **CTRL**: Operações dentro de aplicações
- **ALT**: Navegação e alternativas
- **SHIFT**: Modificador/inversão

### 2. Padrões Mnemônicos
- **Primeira letra = Função**: B=Browser, F=Files, T=Terminal
- **Proximidade = Frequência**: Ações comuns em teclas fáceis
- **Consistência**: Mesma ação sempre na mesma tecla

---

## 🚀 Fluxos Completos Sem Mouse

### 🌅 Início do Dia
```
1. Login → Hyprland inicia
2. SUPER+1 → Workspace 1 (Browser)
3. SUPER+B → Abre Chromium
4. SUPER+2 → Workspace 2 (Editor)
5. SUPER+E → Abre VS Code
6. SUPER+3 → Workspace 3 (Terminal)
7. SUPER+T → Abre Ghostty
```

### 🔍 Fluxo de Pesquisa Web
```
1. SUPER+B → Abre browser
2. CTRL+L → Foco na barra de endereço
3. Digite busca → Enter
4. TAB → Navegar links (múltiplos TABs)
5. Enter → Abrir link
6. CTRL+F → Buscar na página
7. CTRL+W → Fechar aba
```

### 💻 Fluxo de Código
```
1. SUPER+E → Editor
2. CTRL+P → Quick open
3. Digite arquivo → Enter
4. CTRL+G → Ir para linha N
5. Editar...
6. CTRL+S → Salvar (ou SUPER+S smart save)
7. ALT+← → Voltar navegação
```

### 📁 Gerenciamento de Arquivos
```
1. SUPER+F → File manager
2. CTRL+L → Digite caminho
3. TAB → Alternar painéis
4. ↑/↓ → Navegar arquivos
5. SPACE → Marcar múltiplos
6. CTRL+C → Copiar
7. CTRL+V → Colar destino
8. F2 → Renomear
```

### 🔄 Multitasking Avançado
```
1. SUPER+[1-5] → Trocar workspaces rapidamente
2. SUPER+TAB → Alternar janelas no workspace
3. SUPER+HJKL → Mover foco entre janelas
4. SUPER+SHIFT+[1-5] → Mover janela para outro workspace
5. SUPER+R → Resize mode para ajustar layout
6. SUPER+V → Toggle floating quando necessário
```

---

## 🎨 Navegação Sem Mouse

### Dentro de Aplicações
```
Universal:
TAB         → Próximo elemento
SHIFT+TAB   → Elemento anterior
ENTER       → Ativar/Confirmar
SPACE       → Toggle/Selecionar
ESC         → Cancelar/Voltar
↑↓←→        → Navegação direcional

Menus:
ALT+[letra] → Acessar menu direto
↓           → Navegar itens
→           → Entrar submenu
←           → Voltar
ENTER       → Selecionar item
```

### Diálogos e Formulários
```
TAB         → Próximo campo
SHIFT+TAB   → Campo anterior
SPACE       → Marcar checkbox
↑/↓         → Selecionar em dropdown
ALT+↓       → Abrir dropdown
ENTER       → Confirmar/OK
ESC         → Cancelar
ALT+[letra] → Botão com underline
```

---

## 🛠️ Configurações Essenciais

### 1. Desabilitar Aceleração do Mouse
```conf
# Torna o mouse menos tentador
input {
    accel_profile = flat
    sensitivity = -0.5
}
```

### 2. Feedback Visual
```conf
# Destacar janela focada
decoration {
    active_opacity = 1.0
    inactive_opacity = 0.8
}
```

### 3. Atalhos de Emergência
```conf
# Sempre disponíveis
bind = SUPER, slash, exec, show-all-keybindings
bind = CTRL ALT, T, exec, foot  # Terminal backup
```

---

## 📊 Métricas de Progresso

### Semana 1: Fundamentos
- [ ] Memorizar SUPER+[BCEFMNT] para apps
- [ ] Usar SUPER+[1-5] para workspaces
- [ ] Zero cliques no dock/launcher
- [ ] Praticar ALT+TAB fluentemente

### Semana 2: Navegação
- [ ] Dominar SUPER+HJKL para foco
- [ ] Usar TAB em todas as interfaces
- [ ] Implementar smart actions
- [ ] 50% redução no uso do mouse

### Semana 3: Avançado
- [ ] Resize sem mouse (SUPER+R)
- [ ] Criar macros pessoais
- [ ] Usar todos 10 workspaces
- [ ] 90% redução no mouse

### Semana 4: Maestria
- [ ] Dia inteiro sem tocar mouse
- [ ] Criar workflows customizados
- [ ] Ensinar outros
- [ ] 100% produtividade teclado

---

## 💡 Dicas de Memorização

### 1. Associações Mentais
```
SUPER+B = "Browse the web"
SUPER+F = "Find Files"
SUPER+T = "Terminal Time"
SUPER+E = "Edit Everything"
```

### 2. Prática Diária
- **Manhã**: Apps e workspaces
- **Tarde**: Navegação e foco
- **Noite**: Ações avançadas

### 3. Desafios Progressivos
- **Dia 1-7**: Sem dock
- **Dia 8-14**: Sem mouse em apps
- **Dia 15-21**: Resize e grupos
- **Dia 22-30**: 100% teclado

---

## 🚨 Troubleshooting

### "Preciso do mouse para X"
1. Identifique a ação exata necessária
2. Procure o atalho: `SUPER+K`
3. Se não existir, crie um
4. Pratique 10x seguidas

### "Muito lento no início"
- Normal! Velocidade vem com prática
- Foque em precisão primeiro
- Use notificações para feedback
- Celebre pequenas vitórias

### "Esqueço os atalhos"
```conf
# Adicione lembretes visuais
bind = SUPER, B, exec, notify-send "🌐 Browser" && chromium
```

---

## 🏆 Você Dominou Quando...

✅ Passa dias sem mouse  
✅ É mais rápido que com mouse  
✅ Cria seus próprios workflows  
✅ Ensina outros naturalmente  
✅ Mouse acumula poeira  

---

## 🚀 Próximo Nível

### 1. Vim Everywhere
- Vimium no browser
- Vim mode no VS Code
- Vim keybindings no terminal

### 2. CLI Power Tools
- fzf para fuzzy finding
- ripgrep para buscas
- tmux para terminal multiplexing

### 3. Automação
- Scripts para tarefas repetitivas
- Macros para sequências comuns
- Hooks para ações contextuais

---

*"O mouse é uma muleta. O teclado é asas."* 🚀

**Meta final:** 0 cliques por dia, ∞ produtividade