#!/usr/bin/zsh

log=~/dl/tc.log
tc=~/bin/torrentcloud.sh
lock=~/dl/tc.lock

if [ -f "$lock" ]; then
    exit
fi

touch "$lock"

if [ \! -f "$log" ]; then
    touch "$log"
fi

$tc | grep "^[0-9]" | grep -v "[0-9]%" | while read x; do
    t="$(echo "$x" | cut -d$'\t' -f1)"
    r="$(echo "$x" | cut -d$'\t' -f2)"
    r="${r/.*}"
    r="${r:--1}"

    if [ "$r" -ge 0 ]; then
        grep -q "^$t$" "$log"
        if [ $? -ne 0 ]; then
            $tc down $t > /dev/null 2> /dev/null
            if [ $? -eq 0 ]; then
                echo $t >> "$log"
            fi
        fi
    fi
    
    if [ "$r" -ge 10 ]; then
        $tc delete $t > /dev/null
    fi
    if [ "$r" -eq -1 ]; then
        $tc slot $t > /dev/null
    fi
done

rm "$lock"
