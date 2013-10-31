#!/bin/bash

host=starturtle.eu.org
dest=/etc/postfix
postmap=/usr/sbin/postmap

tmp=$(mktemp)

for file in virtual rcpt; do
    if ! curl -so $tmp http://$host/$file; then
        continue
    fi
    if diff -q $tmp /etc/postfix/$file >/dev/null; then
        cp $tmp /etc/postfix/$file
        $postmap /etc/postfix/$file
    fi
done

rm -f $tmp
