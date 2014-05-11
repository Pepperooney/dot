#!/bin/bash

larch=/usr/local/bin/larch
mail2imap=~/bin/mail2imap.sh

$larch --max-retries 0 gmail | grep -q [1-9].failed

if [ $? -ne 0 ]; then
    #everything good, nothing to do
    exit
fi

# failed mails
tmp=$(mktemp)

$larch -V insane --max-retries 0 gmail > $tmp 2>&1

grep APPEND $tmp | while read x tag x; do
    sed -n "/^C: $tag APPEND/,/^S: $tag BAD/p" $tmp | sed -n "s/^C: $tag APPEND Archiv[^\"]*\"\([^\"]*\)\".*/From uwe  \1/p;s/^C: //p" | tr -d "\r" | while read -r line; do
        if [ "${line:0:10}" = "From uwe  " ]; then
            echo "${line:0:10}$(date -d "${line:10}" -R)"
        else
            echo "$line"
        fi
    done | $mail2imap
done

$larch --max-retries 0 gmail | grep total$

rm -f $tmp
