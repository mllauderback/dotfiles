#!/bin/bash

echo "Updating hyprland dotfiles"
mkdir -p $HOME/.config/hypr
cp -r --backup=numbered scripts $HOME/.config/hypr
cp --backup=numbered hyprland.conf $HOME/.config/hypr/hyprland.conf

