#!/bin/bash

target=/srv/erde.lu/mine/ltcbtc.tsv

ltcbtc="$(curl -s 'http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=3' 2>/dev/null | cut -d, -f 4 | cut -d\" -f4)"

echo "$ltcbtc" | grep -q '^[0-9.]*$'
if [ $? -eq 0 ]; then
    printf "%s\t%s %s\n" $ltcbtc $(date "+%F %T") > $target
fi
