#!/bin/bash

log=~/dl/publichd

if [ ! -f $log ]; then
    touch $log
fi

xml="$(curl -s "https://publichd.se/rss.php" | xml2 2>/dev/null)"
if [ $? -ne 0 ]; then exit 1; fi
echo "$xml" | egrep '/item/title|/item/torrent/magnetURI'  | cut -d= -f2- | while read t; do
    t="$(echo "$t" | cut -d' ' -f2-)"
    read r
    if ! grep -qF "$t	$r" $log; then
        printf "%s\t%s\n" "$t" "$r" >> $log
    fi
done
