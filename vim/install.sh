#!/bin/bash

echo "Updating vim dotfiles"
mkdir -p $HOME/.vim
cp $(pwd)/.vimrc $HOME/.vimrc

# install coc extensions
cocdir="$HOME/.config/coc"
if [[ -d $cocdir ]]; then
    echo "Installing coc extensions"
    cp $(pwd)/coc-settings.json $HOME/.vim/coc-settings.json
    cp $(pwd)/package.json $HOME/.config/coc/extensions/package.json
    vim -c 'CocUpdateSync|q'
