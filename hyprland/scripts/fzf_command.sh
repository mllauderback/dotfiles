#!/bin/bash
USER_LEVEL="$HOME/.local/share/applications"
FLATPAKS="$HOME/.local/share/flatpak/exports/share/applications:/var/lib/flatpak/exports/share/applications"
SYSTEM_LEVEL="/usr/local/share/applications:/usr/share/applications"
echo -n "$USER_LEVEL:$FLATPAKS:$SYSTEM_LEVEL" \
    | xargs -d: -I{} -r -- find -L {} -maxdepth 1 -mindepth 1 -printf '%P\n' 2>/dev/null \
    | sort -u \
    | awk -v dirs="$USER_LEVEL:$FLATPAKS:$SYSTEM_LEVEL" '
BEGIN { n=split(dirs,d,":") }
{
    file=$0
    for(i=1;i<=n;i++) {
        path=d[i]"/"file
        name=""; exec=""; in_entry=0
        while((getline line < path)>0) {
            gsub(/\r/, "", line)
            if(line ~ /^\[Desktop Entry\]/) { in_entry=1; continue }
            if(line ~ /^\[/ && in_entry) { break }
            if(!in_entry) continue
            if(line ~ /^Name=/)  name=substr(line,6)
            if(line ~ /^Exec=/)  exec=substr(line,6)
        }
        close(path)
        if(name!="" && exec!="") { print exec"\t"name; break }
    }
}
' \
    | fzf --reverse --border --with-nth=2 --delimiter='\t' \
    | cut -f1 \
    | sed 's/ %[uUfFdDnNickvm]//g' \
    | xargs $HOME/.config/hypr/scripts/lnch > /dev/null 2>&1

