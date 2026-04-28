#!/bin/bash

echo "Updating tmux dotfiles"
mkdir -p $HOME/.config/tmux
cp --backup=numbered $(pwd)/tmux.conf $HOME/.config/tmux/tmux.conf
