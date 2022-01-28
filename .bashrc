# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# SET PS1 WITHOUT COLOR
PS1='[\u@\h \W]\$ '

# SET PS1 WITH COLOR
export PS1="\[$(tput bold)\]\[$(tput setaf 3)\][\[$([ "$EUID" -eq 0 ] && tput setaf 1 || tput setaf 2)\]\u\[$(tput setaf 10)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\w\[$(tput setaf 3)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

# set bash binds
bind "set completion-ignore-case on"

# ===[ alias ] ===
# shortcut
alias \
	e="exit" \
	q="exit" \
	quit="exit" \
	l="clear" \
	b="cd .." \
	cls="clear" \
	s="sudo" \
	uwu="s" \
	owo="s" \
	pwease="s" \
	please="s" \
	fuck='s $(history -p \!\!)' \
	pls="s" \
	plz="s" \
	psa="ps aux" \
	psf="pgrep -af" \
	ka="killall" \
	g="grep -i" \
	f="find . | g -i" \
	vol="pamixer --get-volume" \
	cp="cp -iv" \
	mv="mv -iv" \
	rm="rm -vI" \
	gid="pgrep -x" \
	kp="pkill -9 -f" \
	his="history" \
	clip="xclip -selection clipboard" \
	v="nvim" \
	vim="v" \
	lsf="ls -p | g -v /" \
	r="ranger" \
	ungz="tar -zxvf" \
	sc="shellcheck" \
	ns="netstat -antp" \
	utc="date +%s" \
	dust="du -h | sort -h" \
	dust2="du -h -d 1 | sort -h" \
	nf="neofetch" \
	site="sudo systemctl status httpd" \
	siteup="sudo systemctl start httpd" \
	siterst="sudo systemctl restart httpd" \
	sitedown="sudo systemctl stop httpd" \
	sitelog="tail -f /var/log/httpd/*" \
	sitelogmain="tail -f /var/log/httpd/access_log" \
	sitelogclear="sudo rm -rfi /var/log/httpd/access_log /var/log/httpd/error_log /var/log/httpd/ssl_request_log" \
# look
alias \
	ls="exa --color=auto --group-directories-first" \
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
	updatedb="s updatedb" \
	tree="tree -C" \
	diff="diff --color=auto" \
	ccat="highlight --out-format=ansi" \
	ffmpeg="ffmpeg -hide_banner" \
	ffprobe="ffprobe -hide_banner" \
	ffplay="ffplay -hide_banner" \
	nd="sudo netdiscover" \

# checkers
alias \
	gfx="lspci -k | g -EA3 --color 'VGA|3D|Display'" \
	dupes="find . -type f -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate" \
	sortlessuniq="perl -ne 'print unless \$seen{\$_}++'" \
	gpath="echo "\$PATH" | tr ':' '\n'" \

# long commands
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

# edit
alias \
	edbashrc="v ~/.bashrc" \
	edi3="v ~/.config/i3/config" \
	edi3blocks="v ~/.config/i3/i3blocks.conf" \
	edres="v ~/.Xresources" \

# update
alias \
	update-grub="s grub-mkconfig -o /boot/grub/grub.cfg" \
	kbmap="setxkbmap -model pc105 -layout us,rs,rs -variant ",,latin" -option """ \
	loadbash="PS4='+ $BASH_SOURCE:$LINENO:' bash -xic ''" \
	xu="xrdb ~/.Xresources" \

# web
alias \
	wtr="curl wttr.in" \
	exip="echo -e \$(curl -s ifconfig.me)" \
	4chan-dl="wget -nd -r -l 1 -H -D is2.4chan.org -A png,gif,jpg,jpeg,webm" \
	yt="youtube-dl -i --add-metadata -o '%(title)s.%(ext)s'" \
	yta="youtube-dl -i --extract-audio --audio-format mp3 -f bestaudio/best -o '%(title)s.%(ext)s'" \
	corona="curl https://corona-stats.online" \
	coronars="curl https://corona-stats.online/serbia" \
	dldotfiles="git clone 'https://www.github.com/0xC0LD/dotfiles'"

# CD shortcuts
alias \
	bin="cd \"$HOME/.vip/scripts\"" \
	vip="cd \"$HOME/.vip/\"" \
	wlst="cd \"$HOME/.vip/lists/wordlists\"" \
	cap="cd /media/HDD/Root/dump/cap" \
	dx="cd \"$HOME/Desktop\"" \
	cddx="cd \"$HOME/Desktop\"" \
	cddl="cd \"$HOME/Downloads\"" \
	cdpic="cd \"$HOME/Pictures\"" \
	cddoc="cd \"$HOME/Documents\"" \
	cdmus="cd \"$HOME/Music\"" \
	cdvid="cd \"$HOME/Videos\"" \
	mus="cd /media/HDD/Stuff/media/mp3/Music" \
	cdbg="cd /media/HDD/Stuff/media/img/bg/" \
	p2="source \"$HOME/.vip/pyenv/p2env/bin/activate\"" \
	p3="source \"$HOME/.vip/pyenv/p3env/bin/activate\"" \
	pt="which python ; python --version ; which pip ; pip --version" \
	cda="cd /srv/http" \
	cdac="cd /etc/httpd/conf" \
	cdal="cd /var/log/httpd" \
	l3mon="cd /home/user/.vip/tools/L3MON/server"
