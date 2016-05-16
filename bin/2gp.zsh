#!/bin/zsh

# convert files for Google Photos

size="$(stat -f "%z" "$1")"
md5="$(md5 -q "$1")"

if [ $size -gt 77875200 ]; then echo "too large (max 75MiB)"; exit 1; fi

# generate dummy file
dd if=/dev/zero of="$1.tmp0" bs=100 count=778752 2>/dev/null
dd if="$1" of="$1.tmp0" conv=notrunc 2>/dev/null

convert -size 4160x3120 "rgb:$1.tmp0" "png48:$1.tmp" && rm "$1.tmp0"

# fill in exif-data 
e="$(exiftool -DateTimeOriginal "$1" 2>/dev/null | sed "s/^.*: 20\([0-9][0-9]\)\([0-9: ]*\)/19\1\2/")"
if [ -n "$e" ]; then
# date created -100years (to help sorting in google photos)
    exiftool -m -q -overwrite_original "-DateTimeOriginal=$e" "-Comment=$size:$md5:$PWD:$1" "$1.tmp"
else
# just comment
    exiftool -m -q -overwrite_original "-Comment=$size:$md5:$PWD:$1" "$1.tmp"
fi

# finalize to png
mv "$1.tmp" "$1.png"
