#!/bin/bash

# This is an install script for first-time installs on new systems
# It will set up symlinks to the correct locations from the cloned repo
# This should only be run once.  Any edits made after will be tracked by git.
# Any files or folders already existing in the specified locations are backed up.

# Set the below variables to the correct location:

# hyprland config folder
$hyprland=$HOME/.config/hypr
# .vim folder
$dotvim=$HOME/.vim
# coc config folder
$coc=$HOME/.config/coc
# vimrc
$vimrc=$HOME/.vimrc
# tmux config folder
$tmux=$HOME/.config/tmux
# waybar config folder
$waybar=$HOME/.config/waybar

# hyprland setup
ln -s -b $(pwd)/hyprland $hyprland

# vim/coc setup
ln -s -b $(pwd)/vim/dotvim $dotvim
ln -s -b $(pwd)/vim/vimrc $vimrc
ln -s -b $(pwd)/vim/coc $coc
vim -c 'PlugInstall|q|q'
vim -c "CocInstall $(cat $coc/extensions/package.json | grep -E -o "coc-\w+" | tr '\n' ' ' > package_str)|q"
rm package_str

# tmux setup
ln -s -b $(pwd)/tmux $tmux
git clone https://github.com/tmux-plugins/tpm $tmux/plugins/tpm

# waybar setup
ln -s -b $(pwd)/waybar $waybar
