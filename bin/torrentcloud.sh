#!/bin/bash

host="www.torrentcloud.eu"
uri="/cp/"
u="$(grep "machine $host .*login " ~/.netrc | awk '{print $4}')"
p="$(grep "machine $host .*login $usr" ~/.netrc | awk '{print $6}')"

url="https://$u:$p@$host$uri"

dl="axel -a -n 8"
mp4=~/bin/2mp4
target=~/dl/torrent

err=0

# get files
tmp="$(mktemp)"
curl -s "$url" > "$tmp"
slots_avail="$(egrep -o '<b>[0-9]+</b> available' "$tmp" | egrep -o '[0-9]+')"

t_add() {
    m="$1"
    n="$(echo "$m" | egrep -o "dn=[^&]*" | cut -d= -f2- | tr "+" " ")"

    if [ $slots_avail -gt 0 ]; then
        slots=1
    else
        slots=0
    fi
    if [ -z "$n" ]; then
        read -p "title? " n
    fi

    n="${n/ \[PublicHD\]}"

    printf "adding %s …\n" "$n"
    curl -so /dev/null -F "torrentmagnet=$m" -F "name=$n" -F "slots=$slots" -F "cmdSend=Run" "$url"

    printf "added, check with $0 list if it's running.\n"
}

# list_torrent_numbers / names
t_list() {
    printf "torrent\tratio/full\tslot\ttitle\n"
    grep -o "TORRENT=[0-9]*" "$tmp" | cut -d= -f2 | sort -u | while read t; do
        title="$(grep "titl.*M$t" "$tmp" | sed 's/^.*<b [^>]*>//;s/<.*$//;s/.magnet//')"
        #down="$(curl -s "$url?TORRENT=$t&DOWNLOAD=all" | grep -o "https[^\"]*")"
        ratio="$(egrep -o "TORRENT=$t.*Ratio:</b> [0-9.]+" $tmp | awk '{print $NF}')"
        full="$(egrep -o "TORRENT=$t.* [0-9.]+%" "$tmp" | awk '{print $NF}')"
        slot="$(egrep -o "TORRENT=$t.*SLOT=[0-9]+" "$tmp" | awk -F= '{print $NF}')"
        printf "%d\t%s\t\t%s\t%s\n" "$t" "${ratio:0:7}$full" "$slot" "$title"
    done
}

t_slot() {
    t="$1"
    up="${2:-1}"
    curl -so /dev/null "$url?TORRENT=$t&SLOTS=$up"
    printf "%s (maybe) got %d slot (if available).\n" "$t" "$up"
}

t_delete() {
    t="$1"
    curl -so /dev/null "$url?TORRENT=$t&DELETE=yes"
    printf "%s deleted.\n" "$t"
}

# download torrent $1
t_down() {
    t="$1"
    conv="${2:-y}"
    title="$(grep "titl.*M$t" "$tmp" | sed 's/^.*<b [^>]*>//;s/<.*$//;s/.magnet//')"
    down="$(curl -s "$url?_LIST_ORRENTS&TORRENT=$t&DOWNLOAD=all" | grep -o "https[^\"]*")"
    mkdir /tmp/$$
    cd /tmp/$$
    if [ -n "$down" ]; then
        printf "downloading from %s to %s\n" "$down" "/tmp/$$"
        n=($(curl -Lks "$down" | grep -o "href=\"[^\"]*\"" | cut -d\" -f2 | grep -v "\.\./"))
        while [ ${#n[@]} -gt 0 ]; do
            last=$[${#n[@]}-1]
            if [ ${n[$last]:$[${#n[$last]}-1]:1} == "/" ]; then
                printf "traversing dir: %s\n" "${n[$last]}"
                # directory, add them to the list
                n_tmp="${n[$last]}"
                n_tmp2=($(curl -Lks "$down/$n_tmp" | grep -o "href=\"[^\"]*\"" | cut -d\" -f2 | grep -v "\.\./"))
                for ((i=0;i<${#n_tmp2[@]};i++)); do
                    n[$last]="${n_tmp}${n_tmp2[$i]}"
                    (( last++ ))
                done
            else
                printf "downloading file: %s\n" "${n[$last]}"
                $dl "$down/${n[$last]}"
                if [ "$conv" == "y" ]; then
                    fn="$(echo -e "$(echo "${n[$last]/*\/}" | sed 's/%\([0-9][0-9]*\)/\\x\1/g')")"
                    ext="${n[$last]:$[${#n[$last]}-3]:3}"
                    if [ "$ext" == "mkv" -o "$ext" == "avi" -o "$ext" == "mpg" ]; then
                        printf "converting to mp4: %s\n" "/tmp/$$/$fn"
                        $mp4 "/tmp/$$/$fn"
                    fi
                fi
            fi
            unset n[$last]
        done
        printf "moving %s to %s\n" "/tmp/$$" "$target/$title"
        mv "/tmp/$$" "$target/$title"
    else
        err=1
    fi
    [ -d /tmp/$$ ] && rmdir /tmp/$$
}

t_downwait() {
    while ! $0 down "$1"; do
        $0 list
        read -p "stop with any key" -t 60 -n 1
        if [ $? -eq 0 ]; then break; fi
        echo
    done
}

t_help() {
    echo "help, not implemented"
}

# main
case "${1:-list}" in
    "add") t_add "$2" "$3" ;;
    "list") t_list ;;
    "down") t_down "$2" "$3" ;;
    "delete") t_delete "$2" ;;
    "slot") t_slot "$2" "$3" ;;
    "downwait") t_downwait "$2" ;;
    "help") t_help ;;
esac

rm -f "$tmp"

exit $err
