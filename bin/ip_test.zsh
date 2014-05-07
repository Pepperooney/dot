#!/usr/bin/zsh

old=~/.ip_pi
rr="AAAA"
h="pi.erde.lu"
run=~/dot/bin/ip_new.zsh

if [ ! -f "$old" ]; then touch "$old"; fi

ip_new="$(dig +short "$rr" "$h")"

if [ $? -ne 0 ]; then exit; fi
nc -zw 1 $h 22
if [ $? -ne 0 ]; then exit; fi

ip_old="$(<"$old")"


if [ "$ip_old" != "$ip_new" ]; then
    #echo "$h=$ip_new"
    echo "$ip_new" > "$old"
    $run "$ip_new"
fi
