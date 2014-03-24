#!/bin/bash

log=~/dl/kickass
urls=~/.kickass

if [ ! -f $log ]; then
    touch $log
fi

while read url; do
    xml="$xml$(curl -s "$url" | xml2 2>/dev/null)"
    if [ $? -ne 0 ]; then exit 1; fi
done < "$urls"

echo "$xml" | egrep '/item/title|/item/torrent:magnetURI'  | cut -d= -f2- | while read t; do
    read r
    if ! grep -qF "$t	$r" $log; then
        printf "%s\t%s\n" "$t" "$r" >> $log
    fi
done
