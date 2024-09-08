#!/bin/bash

# Path to your alacritty.toml file
ALACRITTY_CONFIG="$HOME/.config/alacritty/alacritty.toml"

# Get a list of all installed fonts
IFS=$'\n' read -r -d '' -a fonts < <(fc-list : family | grep "Nerd Font" | cut -d ',' -f1 | sort | uniq && printf '\0')

# Function to update the font family in the alacritty config file
update_font_family() {
    font_name="$1"
    echo "Updating font to: $font_name"

    # Use sed to replace the current font family with the new one
    sed -i "s/^family = \".*\"/family = \"$font_name\"/" "$ALACRITTY_CONFIG"
}

# Loop through each font and update the config file
for font in "${fonts[@]}"; do
    update_font_family "$font"
    echo "Font updated to: $font"
    read -n 1 -s # wait for key press
done

