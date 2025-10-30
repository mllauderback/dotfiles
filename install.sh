#!/bin/bash

# Parent installer for dotfiles
# Comment out dotfile installers which you don't want to run
# This script does install plugins or extensions

# waybar
source waybar/install.sh

# hyprland
source hyprland/install.sh

# tmux
source tmux/install.sh

# vim
source vim/install.sh
