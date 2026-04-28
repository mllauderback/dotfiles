#!/bin/bash

echo "Updating vim dotfiles"
mkdir -p $HOME/.vim
cp --backup=numbered $(pwd)/.vimrc $HOME/.vimrc
# automatically install vim plugins after updating .vimrc
vim -c 'PlugInstall|q|q'

# install coc extensions
cocdir="$HOME/.config/coc"
if [[ -d $cocdir ]]; then
    echo "Installing coc extensions"
    cp --backup=numbered $(pwd)/coc-settings.json $HOME/.vim/coc-settings.json
    cp --backup=numbered $(pwd)/package.json $HOME/.config/coc/extensions/package.json
    vim -c "CocInstall $(cat $HOME/.config/coc/extensions/package.json | grep -E -o "coc-\w+" | tr '\n' ' ' > package_str)|q"
fi

