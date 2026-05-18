#!/bin/sh

if pgrep -f "kittyFuzzy" > /dev/null; then
    pkill -f kittyFuzzy
else
    hyprctl dispatch 'hl.dsp.exec_cmd("alacritty -T kittyFuzzy -e $HOME/.config/hypr/scripts/fzf_command.sh", { float = true, size = {800, 500} })'
#    hyprctl dispatch exec "[float; size 800 500;] kitty --name kittyFuzzy sh -c $HOME/.config/hypr/scripts/fzf_command.sh"
fi

