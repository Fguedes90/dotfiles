# 🚀 Hyprland Configuration

**Sistema:** Arch Linux + Hyprland + Omarchy  
**Hardware:** ASUS ROG Flow X13  
**Filosofia:** 100% Keyboard-driven workflow

---

## 📁 Estrutura de Diretórios

```
~/.config/hypr/
├── conf.d/                 # Configurações modulares
│   ├── bindings/          # Keybindings organizados
│   ├── devices/           # Configurações de hardware
│   └── *.conf             # Arquivos de configuração
├── scripts/                # Scripts auxiliares
│   ├── display/           # Scripts de monitor
│   ├── keybindings/       # Scripts de atalhos
│   └── *.sh               # Scripts diversos
├── keybindings/           # Definições YAML para apps
│   ├── apps/              # Keybindings por aplicação
│   └── categories/        # Keybindings por categoria
├── docs/                   # 📚 Documentação completa
│   ├── keybindings/       # Tudo sobre atalhos
│   ├── workflows/         # Guias de uso
│   └── hardware/          # Configurações de HW
└── backups/               # Backups automáticos
```

---

## 🎯 Quick Start

### 1. Ver Estado Atual
```bash
# Verificar conflitos
~/.config/hypr/scripts/check-keybind-conflicts.sh

# Ver todos keybindings
SUPER+K
```

### 2. Documentação Essencial
- 📊 [Estado Atual dos Keybindings](docs/keybindings/current-state.md) - Conflitos e mudanças recentes
- 📖 [Referência Completa](docs/keybindings/reference.md) - Todos os atalhos organizados
- 🚀 [Guia de Implementação](docs/keybindings/implementation-guide.md) - Como fazer mudanças
- ⌨️ [Workflow 100% Teclado](docs/workflows/keyboard-only.md) - Eliminar o mouse

### 3. Atalhos Principais
```
Apps:        SUPER + [B]rowser [E]ditor [F]iles [T]erminal
Workspaces:  SUPER + [1-9,0]
Janelas:     SUPER + [Q]uit [V]float [F]ullscreen
Smart:       SUPER + [S]ave [/]find [Return]terminal
```

---

## 📚 Documentação Completa

### [📂 /docs/keybindings/](docs/keybindings/)
- **[current-state.md](docs/keybindings/current-state.md)** - Estado atual, conflitos, mudanças aplicadas
- **[reference.md](docs/keybindings/reference.md)** - Referência completa de todos keybindings
- **[style-guide.md](docs/keybindings/style-guide.md)** - Princípios e convenções de design
- **[implementation-guide.md](docs/keybindings/implementation-guide.md)** - Como implementar mudanças

### [📂 /docs/workflows/](docs/workflows/)
- **[keyboard-only.md](docs/workflows/keyboard-only.md)** - Workflow completo sem mouse
- **[contextual-help.md](docs/workflows/contextual-help.md)** - Sistema de ajuda contextual por app

### [📂 /docs/hardware/](docs/hardware/)
- **[monitors.md](conf.d/monitors-README.md)** - Configuração de monitores e clamshell

---

## 🛠️ Scripts Principais

### Keybindings
- `check-keybind-conflicts.sh` - Detecta conflitos entre configs
- `show-all-keybindings` - Mostra todos atalhos (SUPER+K)
- `contextual-help.sh` - Ajuda específica por aplicação

### Smart Actions
- `smart-terminal.sh` - Terminal inteligente com splits
- `smart-action.sh` - Ações contextuais (save/find/open)
- `app-detector.sh` - Detecta aplicação ativa

### Display
- `clamshell.sh` - Gerencia modos de monitor
- `monitor-mode-status.sh` - Status do monitor para Waybar

---

## ⚡ Features Implementadas

### ✅ Completo
- App launchers mnemônicos (SUPER + primeira letra)
- Smart actions contextuais
- Sistema de ajuda por aplicação
- Detecção automática de conflitos
- Scripts de validação
- Documentação organizada

### 🚧 Em Progresso
- Visual window switcher
- Command mode (Vim-like)
- Quick actions menu
- Notificações visuais aprimoradas

### 📋 Planejado
- Macros para tarefas comuns
- Training mode para novos usuários
- Integração com Waybar melhorada
- Perfis por atividade

---

## 🎨 Personalização

### Adicionar Nova Aplicação
1. Criar arquivo em `keybindings/apps/[nome].yaml`
2. Usar template existente como base
3. Testar com `SUPER+F1` na aplicação

### Criar Novo Keybinding
1. Verificar conflitos: `./scripts/check-keybind-conflicts.sh`
2. Adicionar em arquivo `.conf` apropriado
3. Documentar em `docs/keybindings/current-state.md`
4. Recarregar: `hyprctl reload`

---

## 🐛 Troubleshooting

### Keybinding Não Funciona
```bash
# 1. Verificar sintaxe
hyprctl reload 2>&1

# 2. Testar comando
hyprctl dispatch exec "comando aqui"

# 3. Ver conflitos
~/.config/hypr/scripts/check-keybind-conflicts.sh
```

### SUPER+K Mostra Tela Vazia
- Script foi corrigido em 2025-07-21
- Verifica se `/home/francis/.local/bin/show-all-keybindings` existe

### Conflitos com Omarchy
- Sempre use `unbind` antes de redefinir
- Veja exemplos em `conf.d/intuitive-apps.conf`

---

## 📝 Contribuindo

1. Faça backup antes de mudanças grandes
2. Teste mudanças incrementalmente
3. Documente suas customizações
4. Compartilhe melhorias úteis

---

## 🔗 Links Úteis

- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Omarchy Framework](https://github.com/omarchy/omarchy)
- [Configurações ASUS ROG](https://asus-linux.org/)

---

*"O mouse é opcional. A produtividade não."* 🚀