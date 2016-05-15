#!/bin/zsh

# convert files for Google Photos

size="$(stat -f "%z" "$1")"

if [ $size -gt 128000000 ]; then echo "too large (max 128MB)"; exit 1; fi

convert -size 4000x4000 "bgra:$1" "png64:$1.tmp" 2>/dev/null

# fill in exif-data 
e="$(exiftool -DateTimeOriginal "$1" 2>/dev/null | sed "s/^.*: 20\([0-9][0-9]\)\([0-9: ]*\)/19\1\2/")"
if [ -n "$e" ]; then
# date created -100years (to help sorting in google photos)
    exiftool -m -q -overwrite_original "-DateTimeOriginal=$e" "-Comment=$size:$PWD:$1" "$1.tmp"
else
# just comment
    exiftool -m -q -overwrite_original "-Comment=$size:$PWD:$1" "$1.tmp"
fi

# finalize to png
mv "$1.tmp" "$1.png"
