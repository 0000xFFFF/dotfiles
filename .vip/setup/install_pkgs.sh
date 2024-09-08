#!/bin/bash
while read -r package; do
	sudo pacman -S --noconfirm "$package"
done < pkgs.txt
