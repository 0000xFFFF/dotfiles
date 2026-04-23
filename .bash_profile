# ~/.bash_profile
[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
        #Hyprland
        startplasma-wayland
        #startx
fi
