#!/bin/bash
while read -r package; do
	sudo pacman -S --needed --noconfirm "$package"
done < pkgs.txt
