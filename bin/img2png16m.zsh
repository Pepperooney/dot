#!/bin/zsh
# convert image to png with max 16mbit pixels and 75mb size

# convert to png
sips "$1" -s format png --out "${1%.*}.tmp" >/dev/null 2>/dev/null

# find max resolution (resize needed?)
mp="$(sips -g pixelWidth -g pixelHeight "${1%.*}.tmp" | awk '/pixel/{a[NR]=$2}END{print a[2]*a[3]}')"
if [ $mp -lt 16000000 ]; then
    r=0
else
    r="$(sips -g pixelWidth -g pixelHeight "${1%.*}.tmp" | awk '/pixel/{a[NR]=$NF}END{if (a[2]>a[3]){x=a[2]; y=a[3]}else{x=a[3]; y=a[2]}  print int(sqrt(16000000*(x/y)))}')"
fi

if [ $r -ne 0 ]; then
    convert "${1%.*}.tmp" -resize "${r}x${r}" "png:${1%.*}.tmp2"
else
    cp "${1%.*}.tmp" "${1%.*}.tmp2"
fi

# if size>75m convert to smaller size
size="$(stat -f "%z" "${1%.*}.tmp2")"

while [ $size -gt $((75*1048576)) ]; do
    if [ $r -eq 0 ]; then
        r="$(sips -g pixelWidth -g pixelHeight "${1%.*}.tmp" | awk '/pixel/{a[NR]=$2}END{if (a[2]>a[3]){print int(a[2]*0.9)}else{print int(a[3]*0.9)}}')"
    else
        r0=$r
        r="$(awk "BEGIN{print int($r*(1-($size/75/1048576-1)/2))}")"
        if [ $r0 -eq $r ]; then r=$((r-1)); fi
    fi
    echo "convert $r - $size"
    convert "${1%.*}.tmp" -resize "${r}x${r}" "png:${1%.*}.tmp2"
    size="$(stat -f "%z" "${1%.*}.tmp2")"
done

rm -f "${1%.*}.tmp"


exiftool -m -q -overwrite_original -tagsFromFile "$1" "${1%.*}.tmp2"
mv "${1%.*}.tmp2" "${1%.*}.png"
