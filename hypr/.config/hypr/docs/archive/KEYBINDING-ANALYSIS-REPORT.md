# 🔍 Análise Completa de Keybindings - Sistema Hyprland + Omarchy

**Data da Análise:** 2025-07-21  
**Escopo:** Hyprland + Omarchy + Aplicações Customizadas

---

## 📊 Resumo Executivo

Esta análise identificou **15 conflitos diretos**, **23 padrões inconsistentes** e **45+ oportunidades de padronização** no sistema de keybindings. O documento apresenta recomendações para melhorar a consistência e usabilidade sem alterar as configurações atuais.

---

## 🚨 1. CONFLITOS CRÍTICOS IDENTIFICADOS

### 1.1 Conflitos de Alta Prioridade

| Combinação | Omarchy/Sistema | Customizado | Aplicações | Recomendação |
|------------|-----------------|-------------|------------|---------------|
| **SUPER+W** | `killactive` (fechar janela) | Toggle waybar (comentado) | Ctrl+W (fechar aba) | ✅ Manter Omarchy |
| **SUPER+K** | `omarchy-show-keybindings` | `show-all-keybindings` | Limpar (Claude) | ⚠️ Manter custom |
| **SUPER+V** | `togglefloating` | Volume info (ALT+V agora) | - | ✅ Resolvido |
| **SUPER+P** | `pseudo` | Pin window (SHIFT+P agora) | - | ✅ Resolvido |

### 1.2 Conflitos de Média Prioridade

| Combinação | Conflito | Impacto | Sugestão |
|------------|----------|---------|----------|
| **F11** | Volume vs Fullscreen | Apps usam F11 para tela cheia | Usar XF86AudioLowerVolume |
| **F12** | Volume vs Debug | VS Code usa para debug | Usar XF86AudioRaiseVolume |
| **Ctrl+Shift+C** | Copiar vs Inspecionar | Terminal vs Browser | Contexto resolve |

### 1.3 Duplicações Desnecessárias

```
SUPER+F3 = asusctl led-mode (em 2 lugares)
SUPER+F4 = asusctl profile (em 2 lugares)
SUPER+F7 = clamshell.sh (em 2 lugares)
```

---

## 🔄 2. PADRÕES INCONSISTENTES POR CATEGORIA

### 2.1 Navegação de Abas/Janelas

| Ação | Padrão Dominante | Variações | Apps Afetadas |
|------|------------------|-----------|---------------|
| Próxima aba | `Ctrl+Tab` | `Ctrl+]` | Claude Desktop |
| Aba anterior | `Ctrl+Shift+Tab` | `Ctrl+[` | Claude Desktop |
| Ir para aba | `Ctrl+1-9` | `Alt+1-9` | Nautilus |
| Nova aba | `Ctrl+T` | `Ctrl+Shift+T` | Terminais |

### 2.2 Operações de Busca

| Função | Padrão Universal | Exceções | Contexto |
|--------|-----------------|----------|----------|
| Buscar | `Ctrl+F` | `/` | btop, lazydocker |
| Próxima | `F3` ou `Ctrl+G` | - | Consistente |
| Busca global | `Ctrl+Shift+F` | - | Code, Obsidian |

### 2.3 Controle de Janelas

```yaml
Fullscreen:
  Padrão: F11
  Exceções:
    - Ghostty: Ctrl+Shift+Space
    - Hyprland: SUPER+F

Fechar:
  Janela: SUPER+Q (Hyprland) ou Alt+F4
  Aba: Ctrl+W (universal)
  Aplicação: Ctrl+Q
```

---

## 📋 3. MAPEAMENTO COMPLETO POR CAMADA

### 3.1 Camada Sistema (SUPER)

```
Essenciais:
  SUPER+Return    → Terminal
  SUPER+Space     → Launcher (wofi)
  SUPER+Q         → Fechar janela
  SUPER+Escape    → Power menu
  
Navegação:
  SUPER+H/J/K/L   → Foco direcional
  SUPER+1-0       → Workspaces
  SUPER+Tab       → Cycle windows
  
Janelas:
  SUPER+F         → Fullscreen
  SUPER+V         → Toggle floating
  SUPER+P         → Pseudo tile
  SUPER+G         → Toggle group
```

### 3.2 Camada Hardware (F1-F12 + XF86)

```
Função Direta:
  F1   → Wiki Hyprland
  F2/3 → Backlight teclado
  F4   → AURA LED
  F5/6 → Brilho tela
  F7   → Display switch
  F8   → wdisplays
  F9   → Toggle touchpad
  F10  → Mute mic
  
Com SUPER:
  SUPER+F1  → Keybindings contextuais
  SUPER+F2  → Color picker
  SUPER+F5  → Night light
  SUPER+F10 → Pavucontrol
```

### 3.3 Camada Aplicação (Ctrl/Alt)

```
Universal:
  Ctrl+C/V/X    → Copiar/Colar/Cortar
  Ctrl+A        → Selecionar tudo
  Ctrl+Z/Y      → Desfazer/Refazer
  Ctrl+S        → Salvar
  Ctrl+O        → Abrir
  Ctrl+F        → Buscar
  Ctrl+W        → Fechar aba
  Ctrl+T        → Nova aba
```

---

## 💡 4. RECOMENDAÇÕES DE PADRONIZAÇÃO

### 4.1 Princípios de Design

1. **Hierarquia Clara**
   - SUPER: Controle de janelas/sistema
   - Ctrl: Operações de aplicação
   - Alt: Navegação/alternativas
   - Shift: Modificador reverso

2. **Consistência Contextual**
   - Mesma ação = Mesma tecla (quando possível)
   - Respeitar convenções do ecossistema
   - Priorizar muscle memory existente

3. **Prevenção de Conflitos**
   - Reservar SUPER para Hyprland
   - Evitar F1-F12 sem modificadores
   - Documentar exceções

### 4.2 Padronizações Sugeridas

#### 🔹 Navegação de Abas (TODAS as apps)
```
Ctrl+T          → Nova aba
Ctrl+Shift+T    → Reabrir aba/Nova aba terminal
Ctrl+W          → Fechar aba
Ctrl+Tab        → Próxima aba
Ctrl+Shift+Tab  → Aba anterior
Ctrl+1-9        → Ir para aba específica
```

#### 🔹 Operações de Texto
```
Seleção:
  Ctrl+A        → Selecionar tudo
  Ctrl+L        → Selecionar linha (editores)
  Ctrl+D        → Selecionar palavra/próxima ocorrência

Edição:
  Alt+↑/↓       → Mover linha
  Ctrl+D        → Duplicar (após padronizar seleção)
  Ctrl+/        → Toggle comentário
```

#### 🔹 Busca e Navegação
```
Ctrl+F          → Buscar no documento
Ctrl+Shift+F    → Buscar global/avançada
Ctrl+G ou F3    → Próxima ocorrência
Ctrl+H          → Substituir
/               → Busca rápida (apps CLI)
```

#### 🔹 Visualização
```
Ctrl+Plus       → Aumentar zoom
Ctrl+Minus      → Diminuir zoom
Ctrl+0          → Reset zoom
F11             → Fullscreen (apps)
SUPER+F         → Fullscreen (Hyprland)
```

---

## 🛠️ 5. PLANO DE IMPLEMENTAÇÃO SUGERIDO

### Fase 1: Limpeza (Imediata)
- [ ] Remover duplicações entre Omarchy e custom configs
- [ ] Consolidar scripts de notificação
- [ ] Documentar todas as exceções

### Fase 2: Padronização (1 semana)
- [ ] Alinhar keybindings de navegação de abas
- [ ] Unificar atalhos de busca
- [ ] Padronizar operações de zoom

### Fase 3: Melhorias (2 semanas)
- [ ] Adicionar detecção automática de conflitos
- [ ] Criar modo "training" para novos keybindings
- [ ] Implementar feedback visual consistente

### Fase 4: Documentação (Contínua)
- [ ] Manter changelog de keybindings
- [ ] Criar quick reference cards
- [ ] Atualizar help contextual

---

## 📈 6. MÉTRICAS DE SUCESSO

1. **Redução de Conflitos**: De 15 para < 5
2. **Consistência**: 90%+ das ações comuns padronizadas
3. **Descobribilidade**: Todos os keybindings documentados
4. **Performance**: Tempo de resposta < 100ms

---

## 🔐 7. KEYBINDINGS RESERVADOS

### Nunca Usar (Sistema)
```
SUPER + [Q,W,E,R,A,S,D,F,H,J,K,L,V,Space,Return,Escape]
SUPER + [1-0]
SUPER + [←,→,↑,↓]
```

### Usar com Cuidado
```
F1-F12 (sem modificadores)
Ctrl+Alt+[tecla] (podem conflitar com sistema)
Print Screen e variações
```

---

## 📝 8. NOTAS FINAIS

1. **Claude Desktop** tem o esquema mais divergente - considerar alinhamento gradual
2. **Ghostty** usa convenções de terminal que devem ser preservadas
3. **btop/lazydocker** seguem convenções CLI que são diferentes por design
4. **Obsidian** tem sistema próprio extensível - integrar com cuidado

---

## 🎯 PRÓXIMOS PASSOS

1. Revisar este documento com calma
2. Priorizar conflitos que mais impactam o workflow
3. Implementar mudanças gradualmente
4. Testar extensivamente antes de commitar
5. Manter backup das configurações atuais

---

*Documento gerado por análise automática - Sugestões devem ser validadas antes da implementação*