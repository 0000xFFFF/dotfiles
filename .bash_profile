# ~/.bash_profile
[[ -f ~/.bashrc ]] && . ~/.bashrc

# path mods
export PATH="$PATH":"$HOME/.vip/scripts":"$HOME/.vip/scripts_ln":"$HOME/.config/i3/scripts"

# default programs
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export READER="zathura"
export FILE="dolphin"

# ===[ COLORS ]===
# man
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
# qt theme
#export QT_QPA_PLATFORMTHEME=qt5ct

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx
fi
