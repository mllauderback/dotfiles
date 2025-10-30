#!/bin/bash

echo "Updating hyprland dotfiles"
mkdir -p $HOME/hypr
cp -r scripts $HOME/.config/hypr/scripts
cp hyprland.conf $HOME/.config/hypr/hyprland.conf

