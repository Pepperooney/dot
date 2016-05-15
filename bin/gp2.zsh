#!/bin/zsh
# convert Google Photos pngs back to files
# -v for verbose printing of size/pwd/directory

v=0
if [ "$1" = "-v" ]; then
    v=1
    shift
fi

comment="$(exiftool -j -comment "$1" | python -c 'import json,sys;j=json.load(sys.stdin);print j[0]["Comment"];')"

size="${comment/:*}"

if [ $v -eq 1 ]; then
    echo "$comment"
fi

convert "png64:$1" "rgba:${1%.png}"
dd if="${1%.png}" of="${1%.png}" bs=1 count=0 seek=$size 2>/dev/null
