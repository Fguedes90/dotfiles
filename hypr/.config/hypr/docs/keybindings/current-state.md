# 📊 Estado Atual dos Keybindings - Hyprland

**Última Atualização:** 2025-07-21  
**Sistema:** Hyprland + Omarchy + Customizações

---

## 🎯 Resumo Executivo

- **Total de Keybindings:** 163 (96 user + 67 Omarchy)
- **Conflitos Resolvidos:** 13
- **Conflitos Ativos:** 10
- **Unbinds Definidos:** 9

---

## ⚡ Mudanças Aplicadas Recentemente

### ✅ Implementado em 2025-07-21

1. **App Launchers Mnemônicos**
   - `SUPER+B` → Chromium (unbind Omarchy)
   - `SUPER+C` → Calculator
   - `SUPER+E` → VS Code  
   - `SUPER+F` → Nautilus (unbind Omarchy)
   - `SUPER+M` → Spotify (unbind Omarchy)
   - `SUPER+N` → Obsidian (unbind Omarchy)
   - `SUPER+T` → Ghostty (unbind Omarchy)
   - `SUPER+D` → Discord (unbind Omarchy)
   - `SUPER+G` → Steam (unbind Omarchy)

2. **Smart Actions**
   - `SUPER+Return` → Terminal inteligente (split se já em terminal)
   - `SUPER+S` → Save contextual
   - `SUPER+/` → Find contextual
   - `SUPER+SHIFT+/` → Help contextual

3. **Conflitos Resolvidos**
   - `SUPER+W` → Mantido killactive (waybar toggle removido)
   - `SUPER+K` → Custom keybind helper (unbind Omarchy)
   - `F11/F12` → Removidos (conflito com apps)

4. **Duplicações Limpas**
   - `SUPER+F3/F4/F7` → Consolidados em function-keys.conf

---

## 🚨 Conflitos Ativos (Requerem Atenção)

| Keybind | Arquivo 1 | Arquivo 2 | Ação Recomendada |
|---------|-----------|-----------|------------------|
| `SUPER+ALT+Left/Right` | devices/rog-flow-x13.conf | workspaces.conf | Escolher um |
| `SUPER+CTRL+C` | system-control.conf | conflict-resolution.conf + rog-flow-x13.conf | Consolidar |
| `SUPER+CTRL+M` | system-control.conf | conflict-resolution.conf + rog-flow-x13.conf | Consolidar |
| `SUPER+CTRL+S` | system-control.conf | conflict-resolution.conf + rog-flow-x13.conf | Consolidar |
| `SUPER+mouse_down/up` | workspaces.conf | Omarchy tiling.conf | Decidir prioridade |
| `,XF86Display` | system-control.conf | rog-flow-x13.conf | Remover duplicata |
| `,XF86Tools` | function-keys.conf:56 | function-keys.conf:94 | Remover duplicata |

---

## 📋 Mapeamento Completo por Categoria

### 🚀 Aplicações (SUPER + Letra)
```
B → Chromium          M → Spotify
C → Calculator        N → Obsidian  
D → Discord           O → Quick Open
E → VS Code           S → Smart Save
F → Nautilus          T → Ghostty
G → Steam             W → (killactive)
```

### 🔢 Workspaces (SUPER + Número)
```
1-9 → Ir para workspace N
0   → Workspace 10
Tab → Última usada
,   → Anterior
.   → Próxima
```

### 🎮 Controle de Janelas
```
SUPER+Q         → Fechar janela
SUPER+F         → Fullscreen (Nautilus movido)
SUPER+V         → Toggle floating
SUPER+P         → Pseudo tile
SUPER+G         → Toggle group (Steam movido)
SUPER+R         → Resize mode
```

### ⌨️ Teclas de Função
```
F1-F6   → Hardware controls
F7      → Display switch
F8      → wdisplays
F9      → Touchpad toggle
F10     → Mic mute
F11/F12 → (Removidos - conflito)

SUPER+F1-F12 → Funções avançadas
```

---

## 🔄 Status de Migração

### Fase 1: Limpeza ✅
- [x] Backup das configurações
- [x] Resolver conflitos críticos
- [x] Limpar duplicações
- [x] Criar script de validação

### Fase 2: Organização ✅
- [x] App launchers mnemônicos
- [x] Smart actions
- [x] Documentação atualizada

### Fase 3: Otimização 🚧
- [ ] Resolver conflitos restantes
- [ ] Implementar visual switcher
- [ ] Criar command mode
- [ ] Adicionar mais smart actions

### Fase 4: Polish ⏳
- [ ] Notificações visuais
- [ ] Feedback de modo
- [ ] Cheatsheet interativo
- [ ] Training mode

---

## 🛠️ Scripts e Ferramentas

### Disponíveis
- `/scripts/check-keybind-conflicts.sh` - Detectar conflitos
- `/scripts/smart-terminal.sh` - Terminal contextual
- `/scripts/smart-action.sh` - Ações contextuais
- `/scripts/keybindings/contextual-help.sh` - Help por app
- `/scripts/keybindings/app-detector.sh` - Detectar app ativa

### Planejados
- `visual-switcher.sh` - Alt+Tab melhorado
- `command-mode.sh` - Modo comando Vim-like
- `quick-actions-menu.sh` - Menu de ações rápidas

---

## 📝 Notas Importantes

1. **Omarchy Overrides**: Sempre use `unbind` antes de redefinir
2. **Conflitos de Mouse**: `SUPER+mouse_down/up` precisa decisão
3. **F11/F12**: Considerar migrar para XF86AudioLowerVolume/RaiseVolume
4. **Duplicações ROG**: Consolidar configs em um único arquivo

---

## 🎯 Próximas Ações

1. **Imediato**
   - Resolver conflitos de `SUPER+CTRL+[CMS]`
   - Decidir sobre mouse scroll bindings
   - Limpar duplicatas XF86

2. **Esta Semana**
   - Implementar visual switcher
   - Testar todos os keybindings
   - Treinar muscle memory

3. **Este Mês**
   - Atingir 100% keyboard-only
   - Documentar workflows pessoais
   - Compartilhar config