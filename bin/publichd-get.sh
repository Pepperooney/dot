#!/bin/bash

log=~/dl/publichd

if [ ! -f $log ]; then
    touch $log
fi

curl -s "https://publichd.se/rss.php" | xml2 | egrep '/item/title|/item/torrent/magnetURI'  | cut -d= -f2- | while read t; do
    t="$(echo "$t" | cut -d' ' -f2-)"
    read r
    if ! grep -qF "$t	$r" $log; then
        printf "$t\t$r\n" >> $log
    fi
done
