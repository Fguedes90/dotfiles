#!/bin/bash
# Script para configurar layout de teclado US alt-intl em todo o sistema

echo "=== Configurando layout US Alternative International ==="

# 1. Configurar para sessão atual (Wayland/Hyprland)
echo "1. Aplicando layout para sessão atual..."
setxkbmap -model pc105 -layout us -variant alt-intl -option compose:ralt 2>/dev/null || echo "   Aviso: setxkbmap não aplicável em Wayland puro"

# 2. Configurar sistema (requer sudo)
echo ""
echo "2. Para configurar permanentemente no sistema, execute:"
echo "   sudo localectl set-x11-keymap us pc105 alt-intl compose:ralt"
echo ""

# 3. Verificar configuração atual
echo "3. Configuração atual:"
echo "   Sistema:"
localectl status | grep -E "(X11 Layout|X11 Variant|X11 Options)" | sed 's/^/   /'

echo ""
echo "   Hyprland:"
grep -E "kb_layout|kb_variant|kb_options" ~/.config/hypr/hyprland.conf | grep -v "^#" | sed 's/^/   /'

echo ""
echo "4. Testando layout:"
echo "   Teste os seguintes caracteres:"
echo "   - Cedilha: ' + c = ç"
echo "   - Til: ~ + a = ã"
echo "   - Acento agudo: ' + e = é"
echo "   - Acento grave: ` + a = à"
echo "   - Trema: \" + u = ü"
echo "   - Circunflexo: ^ + o = ô"
echo ""

echo "5. Criando configuração permanente..."
cat > ~/.config/hypr/conf.d/keyboard-layout.conf << 'EOF'
# Configuração de teclado US Alternative International
# Este arquivo garante o layout correto no Hyprland

input {
  # Layout US Alternative International
  kb_layout = us
  kb_variant = alt-intl
  kb_options = compose:ralt
  
  # Configurações adicionais de teclado
  repeat_rate = 40
  repeat_delay = 600
  
  # Numlock ativo por padrão
  numlock_by_default = true
}
EOF

echo "   ✓ Arquivo criado: ~/.config/hypr/conf.d/keyboard-layout.conf"

echo ""
echo "=== Configuração concluída ==="
echo ""
echo "Comandos úteis:"
echo "- Verificar layout: localectl status"
echo "- Aplicar no sistema: sudo localectl set-x11-keymap us pc105 alt-intl compose:ralt"
echo "- Recarregar Hyprland: SUPER+SHIFT+R"