#!/usr/bin/zsh

feed="$1"

t0=$(mktemp -t $(basename $0))
t1=$(mktemp -t $(basename $0))

curl -sko $t0 "$feed"
xml2 < $t0 > $t1

title="$(grep /rss/channel/title= $t1 | head -n 1 | cut -d= -f2-)"
save="/Backup/Feeds/$title"

cd $TMPDIR

grep /rss/channel/item/enclosure/@url= $t1 | cut -d= -f2- | while read url; do
    file="${url/*\/}"
    /usr/local/bin/acdcli m "$save/$file" >/dev/null 2>/dev/null
    if [ $? -ne 0 ]; then
        curl -so "$file" "$url"
        /usr/local/bin/acdcli ul "$file" "$save" >/dev/null 2>/dev/null
        rm "$file"
    fi
done

rm -f $t0 $t1
