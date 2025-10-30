#!/bin/bash

echo "Updating vim dotfiles"
mkdir -p $HOME/.vim
cp $(pwd)/coc-settings.json $HOME/.vim/coc-settings.json
cp $(pwd)/.vimrc $HOME/.vimrc
