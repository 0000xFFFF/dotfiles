#!/bin/bash
open(){
	app="$1"
	cmd="$2"
	[ -z "$cmd" ] && cmd="$app"
	pgrep -x "$app" || eval $cmd & disown
}

setxkbmap -model pc105 -layout us,rs,rs -variant ",,latin" -option grp:alt_shift_toggle
open compton "compton -b --config ~/.config/compton/config"
open dunst "dunst -conf ~/.config/dunst/dunstrc"
open pa-applet "/opt/pa-applet/src/pa-applet"
open lxpolkit
open nm-applet
open flameshot
open feh --recursive --randomize --bg-fill "/media/SSD/media/bg/BEST"


