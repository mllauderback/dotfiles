#!/bin/bash

echo "Updating tmux dotfiles"
mkdir -p $HOME/.config/tmux
cp $(pwd)/tmux.conf $HOME/.config/tmux/tmux.conf
