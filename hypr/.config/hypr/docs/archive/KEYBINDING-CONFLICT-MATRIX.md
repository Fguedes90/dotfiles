# 🔥 Matriz de Conflitos de Keybindings

## 🎯 Conflitos Diretos (Mesma Tecla, Ações Diferentes)

| Keybind | Sistema/Omarchy | Custom Config | App: Chromium | App: Ghostty | App: Code | App: Claude | Conflito? |
|---------|----------------|---------------|---------------|--------------|-----------|-------------|-----------|
| **SUPER+W** | ❌ killactive | ⚠️ waybar (off) | - | - | - | - | 🔴 SIM |
| **SUPER+K** | 🔑 show-keybinds | 🔧 custom-show | - | - | - | ❌ clear | 🔴 SIM |
| **SUPER+V** | ✓ floating | ~~volume~~ | - | - | - | - | 🟢 Resolvido |
| **SUPER+P** | ✓ pseudo | ~~pin~~ | - | - | - | - | 🟢 Resolvido |
| **F11** | - | 🔊 volume- | 🖥️ fullscreen | - | 🖥️ full | - | 🟡 Contexto |
| **F12** | - | 🔊 volume+ | 🛠️ devtools | - | 🐛 debug | - | 🟡 Contexto |
| **Ctrl+K** | - | - | 🔍 search bar | - | - | 🗑️ clear | 🟢 App Only |
| **Ctrl+Shift+C** | - | - | 🔍 inspect | 📋 copy | - | 📝 copy md | 🟢 App Only |

## 📊 Análise de Padrões por Ação

### 🔄 Navegação de Abas

| Ação | Padrão Mais Comum | Apps que Seguem | Apps Divergentes | % Consistência |
|------|-------------------|-----------------|------------------|----------------|
| Nova aba | `Ctrl+T` | Chromium, Nautilus | Ghostty: `Ctrl+Shift+T` | 75% |
| Fechar aba | `Ctrl+W` | TODOS | - | 100% ✅ |
| Próxima | `Ctrl+Tab` | Chromium, Code, Ghostty | Claude: `Ctrl+]` | 75% |
| Anterior | `Ctrl+Shift+Tab` | Chromium, Code, Ghostty | Claude: `Ctrl+[` | 75% |
| Ir para aba | `Ctrl+[1-9]` | Chromium, Code | Nautilus: `Alt+[1-9]` | 66% |

### 🔍 Busca

| Função | Keybind Universal | Consistência | Exceções |
|--------|------------------|--------------|----------|
| Buscar | `Ctrl+F` | 100% ✅ | - |
| Próxima | `F3` / `Ctrl+G` | 90% ✅ | btop: `/` |
| Anterior | `Shift+F3` | 90% ✅ | - |
| Global | `Ctrl+Shift+F` | 80% ✅ | Nautilus, Chromium: não tem |

### 💾 Operações Básicas

| Ação | Keybind | Consistência | Notas |
|------|---------|--------------|-------|
| Copiar | `Ctrl+C` | 95% ✅ | Terminal: `Ctrl+Shift+C` |
| Colar | `Ctrl+V` | 95% ✅ | Terminal: `Ctrl+Shift+V` |
| Desfazer | `Ctrl+Z` | 100% ✅ | - |
| Refazer | `Ctrl+Y` | 70% | Alguns: `Ctrl+Shift+Z` |

### 🖼️ Visualização

| Função | Keybind Principal | Apps | Alternativas |
|--------|------------------|------|--------------|
| Fullscreen | `F11` | 90% ✅ | Ghostty: `Ctrl+Shift+Space` |
| Zoom In | `Ctrl+Plus` | 100% ✅ | - |
| Zoom Out | `Ctrl+Minus` | 100% ✅ | - |
| Reset Zoom | `Ctrl+0` | 100% ✅ | - |

## 🎨 Mapa de Calor de Conflitos

### Teclas Mais Sobrecarregadas

```
SUPER + [letra]:
  Q: 1 uso ✅
  W: 2 usos 🔴 CONFLITO
  E: 1 uso ✅
  R: 1 uso ✅
  T: livre
  Y: livre
  U: livre
  I: 1 uso ✅
  O: 1 uso ✅
  P: 1 uso ✅ (resolvido)
  
  A: 1 uso ✅
  S: 1 uso ✅
  D: 1 uso ✅
  F: 1 uso ✅
  G: 1 uso ✅
  H: 1 uso ✅
  J: 1 uso ✅
  K: 2 usos 🔴 CONFLITO
  L: 1 uso ✅
  
  Z: livre
  X: 1 uso ✅
  C: 1 uso ✅
  V: 1 uso ✅ (resolvido)
  B: 1 uso ✅
  N: 1 uso ✅
  M: 1 uso ✅
```

### F-Keys Status

```
F1:  ✅ Help/Manual + SUPER combos
F2:  ✅ Keyboard backlight + SUPER combos
F3:  ✅ Keyboard backlight + SUPER combos
F4:  ✅ AURA LED + SUPER combos
F5:  ✅ Brightness + SUPER combos
F6:  ✅ Brightness + SUPER combos
F7:  ✅ Display switch + SUPER combos
F8:  ✅ wdisplays + SUPER combos
F9:  ✅ Touchpad + SUPER combos
F10: ✅ Mic mute + SUPER combos
F11: ⚠️ Volume (conflito potencial com apps)
F12: ⚠️ Volume (conflito potencial com apps)
```

## 🚦 Status de Resolução

| Categoria | Total | Resolvidos | Pendentes | Críticos |
|-----------|-------|------------|-----------|----------|
| Sistema vs Custom | 6 | 4 | 2 | 2 |
| Sistema vs Apps | 2 | 0 | 2 | 0 |
| Entre Apps | 8 | 8 | 0 | 0 |
| **TOTAL** | **16** | **12** | **4** | **2** |

## 📋 Checklist de Ação Imediata

- [ ] 🔴 Resolver SUPER+W (manter Omarchy, remover waybar toggle)
- [ ] 🔴 Decidir SUPER+K (manter custom ou Omarchy?)
- [ ] 🟡 Avaliar F11/F12 para volume (mudar para XF86?)
- [ ] 🟢 Documentar exceções de Ctrl+Shift+C (contexto resolve)
- [ ] 🟢 Padronizar navegação de abas do Claude Desktop

---

*Matriz atualizada em: 2025-07-21*