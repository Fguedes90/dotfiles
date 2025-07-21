source ~/.local/share/omarchy/default/bash/rc

# Configuração de locale - ASUS Flow X13
# Configuração robusta para evitar warnings
export LANG=pt_BR.UTF-8
export LC_CTYPE=pt_BR.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8

# Fallback se pt_BR não estiver disponível
if ! locale -a | grep -q "pt_BR.UTF-8"; then
    export LANG=en_US.UTF-8
    export LC_CTYPE=en_US.UTF-8
fi
# Alias temporário para hyprlock com layout fixo
alias hyprlock='/home/francis/.local/bin/hyprlock-wrapper'