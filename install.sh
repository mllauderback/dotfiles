#!/bin/bash

# Parent installer for dotfiles
# Comment out dotfile installers which you don't want to run
# This script does install plugins or extensions

# waybar
#(cd waybar sh install.sh)

# hyprland
#(cd hyprland sh install.sh)

# tmux
(cd tmux; sh install.sh)

# vim
(cd vim; sh install.sh)
