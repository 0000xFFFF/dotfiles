#!/bin/bash
while read -r package; do
	sudo yay -S "$package"
done < pkgs_native.txt
