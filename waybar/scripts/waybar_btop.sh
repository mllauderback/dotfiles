mouse_x=$(hyprctl cursorpos | awk -F ', ' '{print $1}')
mouse_y=$(hyprctl cursorpos | awk -F ', ' '{print $2}')
num_monitors=$(xrandr | grep -c connected)

x_gap=5
y_gap=5
waybar_h=45
btop_w=800
btop_h=500

monitor_width() {
    local mon="${1:-0}"
    xrandr --listactivemonitors | awk -v mon="$mon" '$1 == mon":" {split($3, a, /[x\/\+]/); print a[1]}'
}

monitor_w_offset() {
    local mon="${1:-0}"
    xrandr --listactivemonitors | awk -v mon="$mon" '$1 == mon":" {split($3, a, /[x\/\+]/); print a[5]}'
}

# not particularly safe since we don't check that the input pid exists - this only gets called in a scope with a pid tho
existing_client_monitor_num() {
    hyprctl clients -j | jq --argjson pid $1 '.[] | select(.pid == $pid) | .monitor'
}

existing_client_address() {
    hyprctl clients -j | jq -r --argjson pid $1 '.[] | select(.pid == $pid) | .address'
}

# this only works for horizontally extended monitors rn.  shouldn't be that hard to add support for vertical
mon_num=-1
mon_w=0
for (( i=0; i<$num_monitors; i++ )) {
    mon_w=$(monitor_width $i)
    mon_w_offset=$(monitor_w_offset $i)
    mon_w_total=$((mon_w + mon_w_offset))

    if (( $mouse_x <= $mon_w_total )); then
        mon_num=$i
        break
    fi
}
if (( $mon_num == -1 )); then
    exit 1 # exit with error code if monitor is still -1
fi

# launch btop in a new floating terminal
x=$(( mon_w - btop_w - x_gap ))
y=$(( waybar_h + y_gap ))
pid=$(pgrep -f "kitty sh -c btop waybar_btop")
if [[ -n $pid ]]; then
    kill $pid
    if (( $mon_num != $(existing_client_monitor_num $pid) )); then
        # start a new instance on the focused monitor if focused monitor and existing instance monitors are different
        hyprctl dispatch exec "[float; size $btop_w $btop_h; move $x $y] kitty sh -c btop waybar_btop";
    fi
else
    hyprctl dispatch exec "[float; size $btop_w $btop_h; move $x $y] kitty sh -c btop waybar_btop";
fi
