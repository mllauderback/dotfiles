#!/bin/bash

echo "Updating waybar dotfiles"
mkdir -p $HOME/.config/waybar
cp --backup=numbered config.jsonc $HOME/.config/waybar/config.jsonc
cp --backup=numbered style.css $HOME/.config/waybar/style.css
cp -r --backup=numbered scripts $HOME/.config/waybar
