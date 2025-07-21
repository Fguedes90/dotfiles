# 🚀 Guia de Implementação de Keybindings

**Tempo Total Estimado:** 35 minutos para quick wins + 30 dias para maestria completa

---

## ⚡ Quick Wins - 5 Minutos

### 1. Verificar Conflitos
```bash
~/.config/hypr/scripts/check-keybind-conflicts.sh
```

### 2. Testar Nova Configuração
```bash
hyprctl reload
```

### 3. Ver Todos Keybindings
```
SUPER+K
```

---

## 🎯 Implementação Progressiva

### 📅 Semana 1: Fundamentos
**Meta:** Reduzir 50% do uso do mouse

#### Configurações Essenciais
```conf
# ~/.config/hypr/conf.d/week1-basics.conf

# Window Management
bind = SUPER, Q, killactive
bind = SUPER, F, fullscreen
bind = SUPER, V, togglefloating
bind = ALT, Tab, cyclenext

# Workspaces
bind = SUPER, 1, workspace, 1
bind = SUPER, 2, workspace, 2
bind = SUPER, 3, workspace, 3

# Apps Essenciais
bind = SUPER, Return, exec, ghostty
bind = SUPER, B, exec, chromium
bind = SUPER, E, exec, code
```

**Tarefas Diárias:**
- [ ] Usar SUPER+[1-3] para workspaces
- [ ] Lançar apps com SUPER+[letra]
- [ ] Fechar janelas com SUPER+Q
- [ ] NÃO tocar no dock

---

### 📅 Semana 2: Produtividade
**Meta:** Reduzir 75% do uso do mouse

#### Adicionar Navegação Avançada
```conf
# Movimento de foco
bind = SUPER, h, movefocus, l
bind = SUPER, j, movefocus, d
bind = SUPER, k, movefocus, u
bind = SUPER, l, movefocus, r

# Smart Actions
bind = SUPER, S, exec, ~/.config/hypr/scripts/smart-action.sh save
bind = SUPER, slash, exec, ~/.config/hypr/scripts/smart-action.sh find
```

**Novos Hábitos:**
- [ ] Navegar janelas com SUPER+HJKL
- [ ] Usar SUPER+S para salvar em qualquer app
- [ ] SUPER+/ para buscar

---

### 📅 Semana 3: Avançado
**Meta:** Reduzir 90% do uso do mouse

#### Modo Resize
```conf
bind = SUPER, R, submap, resize
submap = resize
  bind = , h, resizeactive, -50 0
  bind = , l, resizeactive, 50 0
  bind = , escape, submap, reset
submap = reset
```

**Desafios:**
- [ ] Redimensionar janelas sem mouse
- [ ] Usar todos os 10 workspaces
- [ ] Criar seus próprios atalhos

---

### 📅 Semana 4: Maestria
**Meta:** 100% teclado

#### Customizações Finais
- Implementar visual switcher
- Adicionar command mode
- Criar macros pessoais

---

## 🛠️ Resolução de Problemas

### Conflito Detectado
```bash
# 1. Identificar
~/.config/hypr/scripts/check-keybind-conflicts.sh

# 2. Resolver
unbind = SUPER, X  # Em conflict-resolution.conf
bind = SUPER, X, exec, novo-comando
```

### Keybinding Não Funciona
1. Verificar typos: `hyprctl reload 2>&1`
2. Testar comando: `exec comando-aqui`
3. Verificar conflitos: script acima

### Esqueci o Atalho
- `SUPER+K` - Mostra todos
- `SUPER+SHIFT+/` - Help contextual

---

## 📋 Checklist de Implementação

### Imediato (Hoje)
- [ ] Backup: `cp -r ~/.config/hypr ~/.config/hypr.bak`
- [ ] Instalar dependências: `sudo pacman -S wtype jq`
- [ ] Testar SUPER+K funciona
- [ ] Escolher 3 apps principais

### Esta Semana
- [ ] Memorizar apps: SUPER+[BCEFT]
- [ ] Praticar workspaces: SUPER+[1-5]
- [ ] Desinstalar/esconder dock
- [ ] Configurar terminal splits

### Este Mês
- [ ] Implementar todos os scripts
- [ ] Customizar para seu workflow
- [ ] Documentar suas mudanças
- [ ] Compartilhar melhorias

---

## 💡 Dicas Pro

### Período de Transição
```conf
# Manter ambos por 2 semanas
bind = SUPER, W, exec, notify-send "Use SUPER+Q agora" && killactive
bind = SUPER, Q, killactive
```

### Feedback Visual
```conf
# Adicionar notificações
bind = SUPER, F1, exec, notify-send "🎯 Modo Focus" && focus-mode.sh
```

### Muscle Memory
1. **Semana 1**: Foque em 3-5 atalhos
2. **Semana 2**: Adicione 5 mais
3. **Semana 3**: Use exclusivamente
4. **Semana 4**: Velocidade virá

---

## 📊 Métricas de Sucesso

| Fase | Cliques/Dia | Atalhos Memorizados | Velocidade |
|------|-------------|-------------------|------------|
| Início | 200+ | 0-5 | Baseline |
| Semana 1 | 100 | 10-15 | -20% |
| Semana 2 | 50 | 20-25 | +10% |
| Semana 3 | 20 | 30-35 | +50% |
| Semana 4 | <5 | 40+ | +100% |

---

## 🚨 Erros Comuns

1. **Tentar tudo de uma vez** → Foque em poucos
2. **Não praticar diariamente** → Consistência é chave
3. **Voltar ao mouse** → Remova a tentação
4. **Não personalizar** → Adapte ao SEU workflow
5. **Ignorar feedback** → Use notificações

---

## 🎯 Resultado Final

Após 30 dias você será capaz de:
- ✅ Trabalhar 8h+ sem tocar no mouse
- ✅ Ser 2x mais rápido em tarefas comuns
- ✅ Impressionar colegas com sua eficiência
- ✅ Ter workflow personalizado e otimizado
- ✅ Nunca mais procurar o mouse

---

*"O mouse é opcional. A produtividade não."*