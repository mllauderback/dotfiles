#!/bin/bash

echo "Updating waybar dotfiles"
mkdir -p $HOME/.config/waybar
cp config.jsonc $HOME/.config/waybar/config.jsonc
cp style.css $HOME/.config/waybar/style.css
cp -r scripts $HOME/.config/waybar/scripts
