# ⌨️ Documentação de Keybindings

Documentação completa sobre atalhos de teclado, conflitos e implementação.

## 📄 Documentos

### 📊 [current-state.md](current-state.md)
**Estado atual do sistema de keybindings**
- Conflitos ativos que precisam resolução
- Mudanças aplicadas recentemente
- Status de migração e roadmap
- Scripts e ferramentas disponíveis

### 📖 [reference.md](reference.md)
**Referência completa de todos os keybindings**
- Organizado por categoria (Apps, Janelas, Workspaces, etc.)
- Tabelas de referência rápida
- Keybindings reservados e cuidados
- Modos especiais (resize, etc.)

### 📐 [style-guide.md](style-guide.md)
**Princípios e convenções de design**
- Hierarquia de modificadores (SUPER/CTRL/ALT/SHIFT)
- Padrões recomendados por categoria
- Regras de implementação
- Exemplos de boas práticas

### 🚀 [implementation-guide.md](implementation-guide.md)
**Guia prático de implementação**
- Quick wins de 5 minutos
- Plano de 30 dias para maestria
- Resolução de problemas comuns
- Métricas de progresso

## ⚡ Acesso Rápido

### Ver Keybindings
```bash
# Todos os keybindings interativamente
SUPER+K

# Verificar conflitos
~/.config/hypr/scripts/check-keybind-conflicts.sh

# Help contextual da aplicação atual
SUPER+F1
```

### Fazer Mudanças
1. Ler [current-state.md](current-state.md) para entender conflitos
2. Seguir [style-guide.md](style-guide.md) para convenções
3. Implementar usando [implementation-guide.md](implementation-guide.md)
4. Consultar [reference.md](reference.md) para evitar duplicatas

## 🛠️ Scripts Relacionados
- `/scripts/check-keybind-conflicts.sh` - Detecta conflitos
- `/scripts/keybindings/contextual-help.sh` - Ajuda por app
- `/scripts/smart-action.sh` - Ações contextuais