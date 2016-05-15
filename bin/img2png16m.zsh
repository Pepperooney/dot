#!/bin/zsh
# convert image to png with max 16mbit pixels

# convert to png
sips "$1" -s format png --out "${1%.*}.tmp" >/dev/null 2>/dev/null

# find max resolution
res="$(sips -g pixelWidth -g pixelHeight "${1%.*}.tmp" | awk '/pixel/{a[NR]=$NF}END{if (a[2]>a[3]){x=a[2]; y=a[3]}else{x=a[3]; y=a[2]}  print int(sqrt(16000000*(x/y)))}')"

convert "${1%.*}.tmp" -resize "${res}x${res}" "png:${1%.*}.tmp2" && rm "${1%.*}.tmp"
exiftool -m -q -overwrite_original -tagsFromFile "$1" "${1%.*}.tmp2"
mv "${1%.*}.tmp2" "${1%.*}.png"
