mouse_x=$(hyprctl cursorpos | awk -F ', ' '{print$1}')
mouse_y=$(hyprctl cursorpos | awk -F ', ' '{print $2}')
num_monitors=$(xrandr | grep -c connected)

y_gap=5
waybar_h=45
calendar_w=550
calendar_h=450

app_path="$HOME/.config/waybar/scripts"

monitor_width() {
    local mon="${1:-0}"
    xrandr --listactivemonitors | awk -v mon="$mon" '$1 == mon":" {split($3, a, /[x\/\+]/); print a[1]}'
}

monitor_w_offset() {
    local mon="${1:-0}"
    xrandr --listactivemonitors | awk -v mon="$mon" '$1 == mon":" {split($3, a, /[x\/\+]/); print a[5]}'
}

# not particularly safe since we don't check that the input pid exists - this only gets called in a scope with a pid tho
# existing_client_monitor_num() {
#    hyprctl clients -j | jq -r --arg pid $1 '.[] | select(.pid == ($pid | tonumber)) | .monitor' | head -n 1
#}

existing_client_monitor_num() {
    hyprctl clients -j | jq -r --arg addr "$1" '.[] | select(.address == $addr) | .monitor' | head -n 1
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

# launch calendar in a new floating terminal horizontally centered
x=$(( (mon_w / 2) - (calendar_w / 2) ))
y=$(( waybar_h + y_gap ))
addr=$(hyprctl clients -j | jq -r '.[] | select(.class=="Alacritty" and .title=="waybar_calendar") | .address')
pid=$(hyprctl clients -j | jq -r --arg addr "$addr" '.[] | select(.address == $addr) | .pid')
#pid=$(pgrep -f "alacritty -T waybar_calendar -e $app_path/calendar")
if [[ -n "$pid" && "$pid" != "null" ]]; then
    client_mon=$(existing_client_monitor_num "$addr")
#    echo "$client_mon"
    kill $pid
    if [[ -n "$client_mon" && "mon_num" -ne "client_mon" ]]; then
        # start a new instance on the focused monitor if focused monitor and existing instance monitors are different
        hyprctl dispatch "hl.dsp.exec_cmd(\"alacritty -T waybar_calendar -e $app_path/calendar\", { float = true, size = {$calendar_w, $calendar_h}, move = {$x, $y} })";
    fi
else
    hyprctl dispatch "hl.dsp.exec_cmd(\"alacritty -T waybar_calendar -e $app_path/calendar\", { float = true, size = {$calendar_w, $calendar_h}, move = {$x, $y} })";
fi
