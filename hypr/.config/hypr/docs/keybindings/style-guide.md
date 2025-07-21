# 📐 Guia de Estilo para Keybindings

## 🎯 Filosofia de Design

### Princípios Fundamentais

1. **Hierarquia Clara**: Cada modificador tem um propósito específico
2. **Consistência**: Mesma ação = Mesma tecla (quando possível)
3. **Descobribilidade**: Keybindings devem ser intuitivos
4. **Ergonomia**: Combinações confortáveis e acessíveis
5. **Contexto**: Respeitar convenções do ecossistema

## 🔑 Hierarquia de Modificadores

### SUPER (Win/Cmd)
**Propósito**: Controle do Window Manager e Sistema
```
✅ Use para:
- Controle de janelas (mover, redimensionar, fechar)
- Navegação de workspaces
- Lançar aplicações principais
- Funções do sistema

❌ Evite para:
- Operações dentro de aplicações
- Edição de texto
- Navegação de conteúdo
```

### CTRL (Control)
**Propósito**: Operações de Aplicação
```
✅ Use para:
- Operações de arquivo (salvar, abrir, novo)
- Edição (copiar, colar, desfazer)
- Navegação de abas/documentos
- Zoom e visualização

❌ Evite para:
- Controle de janelas
- Mudança de workspace
```

### ALT (Alt/Option)
**Propósito**: Operações Alternativas e Navegação
```
✅ Use para:
- Menus e barras de ferramentas
- Navegação de histórico
- Operações alternativas
- Modificador secundário

❌ Evite para:
- Operações primárias
- Conflitos com menus
```

### SHIFT
**Propósito**: Modificador de Inversão/Extensão
```
✅ Use para:
- Inverter ação (Tab vs Shift+Tab)
- Estender seleção
- Variação de comando
- Ações "maiores" (nova janela vs nova aba)

❌ Evite para:
- Ações completamente diferentes
- Uso isolado
```

## 📋 Padrões Recomendados por Categoria

### 🪟 Window Management (SUPER)
```yaml
Essenciais:
  SUPER + Q:        Fechar janela
  SUPER + F:        Fullscreen
  SUPER + V:        Toggle floating
  SUPER + Space:    Launcher
  SUPER + Return:   Terminal

Navegação:
  SUPER + [1-0]:    Workspace direto
  SUPER + Tab:      Cycle windows
  SUPER + [HJKL]:   Foco direcional
  SUPER + [←→↑↓]:   Alternativa arrows

Movimento:
  SUPER + Shift + [1-0]:   Mover para workspace
  SUPER + Shift + [HJKL]:  Mover janela
  SUPER + Mouse:           Mover/Redimensionar
```

### 📝 Edição Universal (CTRL)
```yaml
Básico:
  Ctrl + C:      Copiar
  Ctrl + X:      Cortar  
  Ctrl + V:      Colar
  Ctrl + A:      Selecionar tudo
  Ctrl + Z:      Desfazer
  Ctrl + Y:      Refazer (ou Ctrl+Shift+Z)

Arquivo:
  Ctrl + S:      Salvar
  Ctrl + O:      Abrir
  Ctrl + N:      Novo
  Ctrl + P:      Imprimir/Command Palette

Busca:
  Ctrl + F:      Buscar
  Ctrl + H:      Substituir
  Ctrl + G:      Próxima ocorrência
```

### 🔄 Navegação de Abas (CTRL)
```yaml
Padrão:
  Ctrl + T:            Nova aba
  Ctrl + W:            Fechar aba
  Ctrl + Tab:          Próxima aba
  Ctrl + Shift + Tab:  Aba anterior
  Ctrl + [1-9]:        Aba específica

Terminal Exception:
  Ctrl + Shift + T:    Nova aba (terminal)
  Ctrl + Shift + W:    Fechar aba (terminal)
```

### 🖼️ Visualização (CTRL)
```yaml
Zoom:
  Ctrl + Plus:   Aumentar
  Ctrl + Minus:  Diminuir
  Ctrl + 0:      Reset (100%)

Display:
  F11:           Fullscreen (app)
  Ctrl + L:      Foco em barra de endereço/local
```

### ⚡ Ações Rápidas (Sem Modificador)
```yaml
Função:
  F1:    Ajuda
  F2:    Renomear
  F3:    Buscar próximo
  F4:    Fechar (Alt+F4)
  F5:    Atualizar
  F11:   Fullscreen
  F12:   Developer tools

Navegação:
  Tab:          Próximo elemento
  Space:        Ativar/Selecionar
  Enter:        Confirmar/Abrir
  Escape:       Cancelar/Sair
  Backspace:    Voltar
```

## 🚫 Combinações Reservadas

### Nunca Sobrescrever
```
Sistema Crítico:
- Ctrl + Alt + Delete
- Ctrl + Alt + F[1-7]
- Alt + Tab
- Alt + F4
- Print Screen

Omarchy Core:
- SUPER + [QWEASDFHJKL]
- SUPER + [1234567890]
- SUPER + Space
- SUPER + Return
- SUPER + Escape
```

### Use com Extrema Cautela
```
- SUPER + CTRL + [tecla]:      Reserved for system
- CTRL + ALT + [tecla]:        Often system shortcuts
- Single F-keys:               Hardware/BIOS functions
- XF86* keys:                  Hardware controls
```

## 📏 Regras de Implementação

### 1. Verificação de Conflitos
Antes de adicionar novo keybinding:
```bash
# Verificar Omarchy
grep -r "bind.*TECLA" ~/.local/share/omarchy/

# Verificar Custom
grep -r "bind.*TECLA" ~/.config/hypr/

# Verificar Apps
grep -r "TECLA" ~/.config/hypr/keybindings/
```

### 2. Documentação Obrigatória
Todo keybinding deve ter:
```conf
# Descrição clara do que faz
# Categoria: Window/App/System/Media
# Conflitos: Lista se sobrescreve algo
bind = SUPER, X, exec, comando # Comentário inline
```

### 3. Ordem de Prioridade
1. Hardware/BIOS (F-keys diretas)
2. Omarchy/Sistema (SUPER)
3. Aplicações (CTRL/ALT)
4. Custom user (SUPER+ALT)

### 4. Testes Requeridos
- [ ] Funciona em todas as aplicações?
- [ ] Conflita com keybinds existentes?
- [ ] É ergonomicamente confortável?
- [ ] Segue as convenções da categoria?
- [ ] Está documentado adequadamente?

## 🎨 Exemplos de Boas Práticas

### ✅ BOM: Consistente e Intuitivo
```conf
# Screenshot com seleção de área (comum em muitos sistemas)
bind = SUPER SHIFT, S, exec, grimblast copy area

# Color picker (P de "Pick")
bind = SUPER, P, exec, hyprpicker -a
```

### ❌ RUIM: Confuso e Inconsistente
```conf
# Q normalmente é "Quit", não "Quick note"
bind = SUPER, Q, exec, quick-note

# Ctrl+S é universalmente "Save", não "Search"  
bind = CTRL, S, exec, search-tool
```

## 📚 Referências de Convenções

### Por Plataforma
- **Windows**: [Microsoft Guidelines](https://docs.microsoft.com/en-us/windows/win32/uxguide/inter-keyboard)
- **macOS**: [Apple HIG](https://developer.apple.com/design/human-interface-guidelines/macos/user-interaction/keyboard/)
- **GNOME**: [GNOME HIG](https://developer.gnome.org/hig/stable/keyboard.html)
- **KDE**: [KDE Standards](https://hig.kde.org/patterns/command/keyboard.html)

### Por Aplicação
- **VS Code**: Ctrl-based, multi-cursor aware
- **Vim**: Modal, single-key commands
- **Emacs**: Ctrl/Meta heavy, chorded
- **Browser**: Web standards (Ctrl+T, Ctrl+W, etc)

---

*Última atualização: 2025-07-21*  
*Mantenha este guia atualizado com novas convenções descobertas*