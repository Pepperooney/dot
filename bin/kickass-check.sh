#!/bin/bash

log=~/dl/kickass
checked=~/dl/kickass.checked

if [ ! -f $log ]; then
    echo no log
    exit 1
fi
if [ ! -f $checked ]; then
    touch $checked
fi

tmp1=$(mktemp)
tmp2=$(mktemp)

sort $log > $tmp1
sort $checked > $tmp2

comm -3 $tmp1 $tmp2 | cut -d$'\t' -f1
cp $log $checked

rm $tmp1 $tmp2
