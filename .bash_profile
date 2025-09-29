# ~/.bash_profile
[[ -f ~/.bashrc ]] && . ~/.bashrc

# path mods
export PATH="$PATH":"$HOME/.vip/scripts":"$HOME/.vip/scripts_ln":"$HOME/.config/i3/scripts"

# default programs
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export READER="okular"
export FILE="dolphin"

# bash history
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export HISTCONTROL=ignoreboth # ignore dupes


# less, man colors
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)

# disable opencl for libreoffice
export SAL_DISABLE_OPENCL=1

export QT_QPA_PLATFORMTHEME=qt6ct

#if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
#        #startplasma-wayland
#        #startx
#fi
