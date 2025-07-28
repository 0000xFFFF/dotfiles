# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# SET PS1 WITHOUT COLOR
PS1='[\u@\h \W]\$ '


# SET PS1 WITH COLOR
export PS1="\[$(tput bold)\]\[$(tput setaf 3)\][\[$([ "$EUID" -eq 0 ] && tput setaf 1 || tput setaf 2)\]\u\[$(tput setaf 10)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\w\[$(tput setaf 3)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

# PS1 COLOR WITH BRANCH NAME

GIT_PROMPT="/usr/share/git/git-prompt.sh"
if [ -f "$GIT_PROMPT" ]; then
    source "$GIT_PROMPT"
    export PS1="\[$(tput bold)\]\[$(tput setaf 3)\][\[$([ "$EUID" -eq 0 ] && tput setaf 1 || tput setaf 2)\]\u@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\w\[$(tput setaf 3)\]]\[$(tput sgr0)\]\[$(tput setaf 1)\]\$(__git_ps1 '-[%s]-')\[$(tput bold)\]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
fi



bind "set completion-ignore-case on"
set -o vi # use vim bindings

# ===[ alias ] ===
# main
alias \
        e="exit" \
        q="e" \
        quit="e" \
        l="clear" \
        b="cd .." \
        cls="l" \
        s="sudo" \
        psa="ps aux" \
        psf="pgrep -af" \
        ka="killall" \
        g="grep -i" \
        f="find . | g -i" \
        ff="fzf" \
        cp="cp -iv" \
        mv="mv -iv" \
        rm="rm -vI" \
        gid="pgrep -x" \
        kp="pkill -9 -f" \
        his="history" \
        v="nvim" \
        vim="v" \
        lsf="ls -p | g -v /" \
        r="ranger" \
        sc="shellcheck" \
        ns="netstat -antp" \
        utc="date +%s" \
        cursor_show="printf '\033[?25h'" \
        cursor_hide="printf '\033[?25l'" \
        clear2="printf '\033[0;0H'" \
        ls="exa --color=auto --icons --group-directories-first" \
        la="ls -la" \
        laa="ls -abghHliS" \
        grep="grep --color=auto" \
        p="s pacman --color=auto" \
        pac="p" \
        pacman="p" \
        paci="p -S" \
        pacs="p -Ss" \
        pacr="p -Rns" \
        pacq="p -Qs" \
        pacu="p -Syuu" \
        pacc="p -Scc" \
        xi="sudo xbps-install" \
        xs="sudo xbps-query -Rs" \
        xr="sudo xbps-remove -R" \
        updatedb="s updatedb" \
        tree="tree -C" \
        diff="diff --color=auto" \
        cat="bat" \
        t="tmux" \
        lg="lazygit" \

# handy
alias \
        fuck='s $(history -p \!\!)' \
        vol="pamixer --get-volume" \
        clip="xclip -selection clipboard" \
        nf="fastfetch" \
        ungz="tar -zxvf" \
        ccat="highlight --out-format=ansi" \
        ffmpeg="ffmpeg -hide_banner" \
        ffprobe="ffprobe -hide_banner" \
        ffplay="ffplay -hide_banner" \
        systemctl="s systemctl" \

# site
alias \
        site="s systemctl status httpd" \
        siteup="s systemctl start httpd" \
        siterst="s systemctl restart httpd" \
        sitedown="s systemctl stop httpd" \
        sitelog="tail -f /var/log/httpd/*" \
        sitelogmain="tail -f /var/log/httpd/access_log" \
        sitelogclear="s rm -rfi /var/log/httpd/access_log /var/log/httpd/error_log /var/log/httpd/ssl_request_log" \
        upall="pm2 start all ; systemctl start httpd ; systemctl status httpd" \
        downall="pm2 stop all ; systemctl stop httpd ; systemctl status httpd" \
        statall="pm2 status ; systemctl status httpd" \

# hax
alias \
        rpf="s radeon-profile" \
        nd="s netdiscover" \
        tshark-http="tshark -Y 'http.request.method == GET' -i" \
        tshark-icmp="tshark -Y 'icmp' -i" \
        tcpdump-icmp="tcpdump -vv icmp -i" \

# checkers
alias \
        gfx="lspci -k | g -EA3 --color 'VGA|3D|Display'" \
        dupes="find . -type f -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate" \
        sortlessuniq="perl -ne 'print unless \$seen{\$_}++'" \
        gpath="echo "\$PATH" | tr ':' '\n'" \
        ports="ss -tuln -p" \

# cool stuff
alias \
        feh="feh --scale-down --auto-zoom -d" \
        fehbg="feh --recursive --randomize --bg-fill" \
        clc="history -p !! | tr -d '\n' | xclip -selection clipboard" \
        clcn="history -p !! | xclip -selection clipboard" \
        cmaim="maim -s -u | xclip -selection clipboard -t image/png -i" \
        xc="compton -b --config \"$HOME/.config/compton/config\"" \
        dump="mkdir dump ; cd dump" \
        fbg="feh --bg-fill ~/.wallpaper" \
        open="dolphin --select" \
        nogpu="LIBGL_ALWAYS_SOFTWARE=1 eval"

# edit
alias \
        edbashrc="v ~/.bashrc" \
        edi3="v ~/.config/i3/config" \
        edi3blocks="v ~/.config/i3/i3blocks.conf" \
        edres="v ~/.Xresources" \
        edtmux="v ~/.config/tmux/tmux.conf" \
        edvim="v ~/.config/nvim/init.vim" \
        edhy="v ~/.config/hypr/hyprland.conf" \

# update
alias \
        update-grub="s grub-mkconfig -o /boot/grub/grub.cfg" \
        kbmap="setxkbmap -model pc105 -layout us,rs,rs -variant ",,latin" -option """ \
        loadbash="PS4='+ $BASH_SOURCE:$LINENO:' bash -xic ''" \
        xu="xrdb ~/.Xresources" \
        tmuxu="tmux source ~/.config/tmux/tmux.conf" \

# web
alias \
        wtr="curl wttr.in" \
        exip="echo -e \$(curl -s ifconfig.me)" \
        4chan-dl-wget="wget -nd -r -l 1 -H -D is2.4chan.org -A png,gif,jpg,jpeg,webm" \
        yt_old="youtube-dl -i --add-metadata -o '%(title)s.%(ext)s'" \
        yta_old="youtube-dl -i --extract-audio --audio-format mp3 -f bestaudio/best -o '%(title)s.%(ext)s'" \
        yt="yt-dlp -i --add-metadata -o '%(title)s.%(ext)s'" \
        yta="yt-dlp -i --extract-audio --audio-format mp3 -f bestaudio/best -o '%(title)s.%(ext)s'" \
        corona="curl https://corona-stats.online" \
        coronars="curl https://corona-stats.online/serbia" \
        dldotfiles="git clone 'https://www.github.com/0000xFFFF/dotfiles'" \
        parrot="curl parrot.live" \

# CD shortcuts
alias \
        bin="cd \"$HOME/.vip/scripts\"" \
        vip="cd \"$HOME/.vip/\"" \
        wlst="cd \"$HOME/.vip/lists/wlst\"" \
        cap="cd /run/media/user/57020afc-0ec3-49d9-8968-3000c1a37462/dump/pcapng/all" \
        dx="cd \"$HOME/Desktop\"" \
        cddx="cd \"$HOME/Desktop\"" \
        cddl="cd \"$HOME/Downloads\"" \
        cdpic="cd \"$HOME/Pictures\"" \
        cddoc="cd \"$HOME/Documents\"" \
        cdmus="cd \"$HOME/Music\"" \
        cdvid="cd \"$HOME/Videos\"" \
        mus="cd /media/SSD/media/music" \
        cdbg="cd /media/SSD/media/bg" \
        p2="source \"$HOME/.vip/pyenv/p2env/bin/activate\"" \
        p3="source \"$HOME/.vip/pyenv/p3env/bin/activate\"" \
        pt="which python ; python --version ; which pip ; pip --version" \
        cda="cd /srv/http" \
        cdac="cd /etc/httpd/conf" \
        cdal="cd /var/log/httpd" \
        l3mon="cd $HOME/.vip/tools/L3MON/server"

# add beter cd with zoxide
eval "$(zoxide init bash)"
alias cd="z"

# # dont run in tmux, tty, ...
# if command -v tmux &> /dev/null && \
#    [ -n "$PS1" ] && \
#    [[ ! "$TERM" =~ screen ]] && \
#    [[ ! "$TERM" =~ tmux ]] && \
#    [ -z "$TMUX" ] && \
#    [ -t 1 ] && \
#    [[ ! "$(tty)" =~ /dev/tty[0-9]+ ]]; then
#   exec tmux
# fi
