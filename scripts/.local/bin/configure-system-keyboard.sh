#!/bin/bash
# Script para configurar teclado US alt-intl no sistema

echo "Este script configura o teclado US Alternative International no sistema."
echo "Você precisará digitar sua senha de sudo."
echo ""

# Configurar o teclado no sistema
sudo localectl set-x11-keymap us pc105 alt-intl compose:ralt

# Verificar se funcionou
if [ $? -eq 0 ]; then
    echo "✓ Teclado configurado com sucesso!"
    echo ""
    localectl status
else
    echo "✗ Erro ao configurar teclado"
    exit 1
fi

echo ""
echo "Configuração aplicada. O layout está ativo para:"
echo "- Console (TTY)"
echo "- X11/Xwayland"
echo "- Hyprland (já estava configurado)"