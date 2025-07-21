# 📅 Plano de Implementação - Workflow 100% Teclado

## 🎯 Meta: Eliminar uso do mouse em 30 dias

### 📊 Métricas de Sucesso
- **Semana 1**: 50% redução no uso do mouse
- **Semana 2**: 75% redução 
- **Semana 3**: 90% redução
- **Semana 4**: 100% teclado (mouse apenas emergência)

---

## 📆 Semana 1: Fundamentos
*Foco: Navegação básica e apps essenciais*

### Dia 1-2: Window Management
```conf
# Adicione ao seu config:
bind = SUPER, Q, killactive
bind = SUPER, F, fullscreen
bind = SUPER, V, togglefloating
bind = ALT, Tab, cyclenext
```
**Pratique**: Abrir, mover e fechar janelas sem mouse

### Dia 3-4: Workspace Navigation
```conf
bind = SUPER, 1, workspace, 1
bind = SUPER, 2, workspace, 2
bind = SUPER, 3, workspace, 3
bind = SUPER, Tab, workspace, previous
```
**Meta**: Organizar apps em workspaces fixos

### Dia 5-7: App Launching
```conf
bind = SUPER, Return, exec, ghostty
bind = SUPER, B, exec, chromium
bind = SUPER, F, exec, nautilus
bind = SUPER, Space, exec, wofi --show drun
```
**Desafio**: Não use o dock/menu com mouse

---

## 📆 Semana 2: Produtividade
*Foco: Ações rápidas e navegação avançada*

### Dia 8-10: Focus & Movement
```conf
# Navegação direcional
bind = SUPER, h, movefocus, l
bind = SUPER, j, movefocus, d
bind = SUPER, k, movefocus, u
bind = SUPER, l, movefocus, r

# Mover janelas
bind = SUPER SHIFT, h, movewindow, l
bind = SUPER SHIFT, j, movewindow, d
bind = SUPER SHIFT, k, movewindow, u
bind = SUPER SHIFT, l, movewindow, r
```

### Dia 11-13: Quick Actions
```conf
# Screenshots
bind = , Print, exec, grimblast copy area
bind = SUPER, Print, exec, grimblast save area

# Volume
bind = SUPER, equal, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
bind = SUPER, minus, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-

# Media
bind = SUPER, backslash, exec, playerctl play-pause
```

### Dia 14: Review & Customize
- Identifique suas ações mais frequentes
- Crie atalhos personalizados
- Remova atalhos não usados

---

## 📆 Semana 3: Avançado
*Foco: Modos especiais e otimizações*

### Dia 15-17: Resize Mode
```conf
bind = SUPER, R, submap, resize
submap = resize
  bind = , h, resizeactive, -50 0
  bind = , l, resizeactive, 50 0
  bind = , k, resizeactive, 0 -50
  bind = , j, resizeactive, 0 50
  bind = , escape, submap, reset
submap = reset
```

### Dia 18-20: Smart Scripts
```bash
# quick-note.sh
#!/bin/bash
NOTE_FILE="$HOME/Notes/quick-$(date +%Y%m%d-%H%M%S).md"
echo "# Quick Note - $(date)" > "$NOTE_FILE"
ghostty -e nvim "$NOTE_FILE"
```

```conf
bind = SUPER, Z, exec, ~/.config/hypr/scripts/quick-note.sh
```

### Dia 21: Contextual Actions
```conf
# Help contextual
bind = SUPER, slash, exec, ~/.config/hypr/scripts/keybindings/contextual-help.sh

# Smart open
bind = SUPER, O, exec, ~/.config/hypr/scripts/smart-open.sh
```

---

## 📆 Semana 4: Maestria
*Foco: Eliminar últimas dependências do mouse*

### Dia 22-24: App-Specific Navigation
- Configure keybindings internos das apps
- Aprenda atalhos do browser (vimium?)
- Domine navegação no file manager

### Dia 25-27: Edge Cases
```conf
# Color picker
bind = SUPER, I, exec, hyprpicker -a

# Emoji picker
bind = SUPER, semicolon, exec, wofi-emoji

# Clipboard history
bind = SUPER, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy
```

### Dia 28-30: Polish & Optimize
- Ajuste timings e delays
- Crie macros para tarefas repetitivas
- Documente seu setup

---

## 🛠️ Troubleshooting Comum

### "Esqueci o atalho!"
```conf
# Sempre disponível:
bind = SUPER, slash, exec, show-all-keybindings
```

### "Preciso do mouse para X"
1. Identifique a ação exata
2. Pesquise se existe atalho
3. Crie um se não existir
4. Pratique 10x seguidas

### "Muito lento com teclado"
- Normal nas primeiras semanas
- Foque em accuracy, não velocidade
- Velocidade vem com muscle memory

---

## 📈 Tracking Progress

### ~/.config/hypr/keyboard-progress.md
```markdown
## Semana 1
- [ ] Consigo fechar janelas sem mouse
- [ ] Navego workspaces facilmente  
- [ ] Abro apps principais por atalho
- [ ] Uso Alt+Tab fluentemente

## Semana 2
- [ ] Movimento de janelas natural
- [ ] Screenshots sem mouse
- [ ] Controle volume/mídia OK
- [ ] 50% menos uso do mouse

## Semana 3
- [ ] Resize rápido e preciso
- [ ] Scripts auxiliares funcionando
- [ ] Navegação em apps melhorou
- [ ] 75% menos mouse

## Semana 4
- [ ] Workflow completamente fluido
- [ ] Mouse apenas para precisão
- [ ] Criei meus próprios atalhos
- [ ] 95%+ teclado
```

---

## 🏆 Graduação

### Você dominou quando:
1. ✅ Passa dias sem tocar no mouse
2. ✅ É mais rápido com teclado
3. ✅ Cria seus próprios workflows
4. ✅ Ensina outros a usar
5. ✅ Mouse sente falta de você

### Próximos Passos
- Explore ferramentas CLI avançadas
- Aprenda Vim motions everywhere
- Contribua com scripts para comunidade
- Torne-se um keyboard warrior! ⚔️

---

## 💡 Dicas Finais

1. **Seja paciente**: Muscle memory leva tempo
2. **Seja consistente**: Use sempre os atalhos
3. **Seja curioso**: Sempre há um jeito melhor
4. **Seja criativo**: Invente seus workflows
5. **Seja produtivo**: Foque no resultado, não na ferramenta

---

*"O mouse é uma muleta. O teclado é asas."* 🚀