#!/bin/bash

sync_hyprland() {
    cp $HOME/.config/hypr/hyprland.conf $(pwd)/hyprland/hyprland.conf
    cp -r $HOME/.config/hypr/scripts $(pwd)/hyprland/.
}

sync_waybar() {
    cp $HOME/.config/waybar/config.jsonc $(pwd)/waybar/config.jsonc
    cp $HOME/.config/waybar/style.css $(pwd)/waybar/style.css
    cp -r $HOME/.config/waybar/scripts $(pwd)/waybar/.
}

sync_tmux() {
    cp $HOME/.config/tmux/tmux.conf $(pwd)/tmux/tmux.conf
}

sync_vim() {
#    cocdir="$HOME/.config/coc"
#    if [[ -d $cocdir ]]; then
#        cp $HOME/.config/coc/extensions/package.json $(pwd)/vim/package.json
#        cp $HOME/.vim/coc-settings.json $(pwd)/vim/coc-settings.json
#    fi
    cp $HOME/.vimrc $(pwd)/vim/.vimrc
}

sync_hyprland
sync_waybar
sync_tmux
sync_vim
