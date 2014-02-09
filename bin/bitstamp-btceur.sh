#!/bin/bash

target=/srv/erde.lu/mine/btceur.tsv

btcusd=$(curl -s https://www.bitstamp.net/api/ticker/ | ~/bin/json.sh -b | awk '/ask/{print substr($2,2,length($2)-2)}')
usdeur=$(curl -s https://www.bitstamp.net/api/eur_usd/ | ~/bin/json.sh -b | awk '/sell/{print substr($2,2,length($2)-2)}')

btceur=$(echo "scale=4;$btcusd/$usdeur" | bc 2>/dev/null)

if [ $? -eq 0 ]; then
    printf "%s\t%s %s\n" $btceur $(date "+%F %T") > $target
fi
