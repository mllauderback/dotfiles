#/bin/bash

terminal=kitty
pid=$(ps aux | grep -i "$terminal sh -c btop waybar_btop" | grep -v grep | awk '{print $2}')
screen_h=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f2)
screen_w=$(xdpyinfo | awk '/dimensions/{print $2}' | cut -d 'x' -f1)
x_gap=5
y_gap=5
waybar_h=45
btop_h=500
btop_w=800

if [[ -n $pid ]]; then
    kill $pid;
else
    hyprctl dispatch exec "[float; size $btop_w $btop_h; move $[$screen_w-$btop_w-$x_gap] $[$waybar_h+$y_gap]] $terminal sh -c btop waybar_btop";
fi
