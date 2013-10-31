#!/bin/bash

host=starturtle.eu.org
dest=/etc/postfix
postmap=/usr/sbin/postmap

tmp=$(mktemp)

for file in virtual rcpt; do
    if ! curl -so $tmp http://$host/$file; then
        continue
    fi
    if ! cmp -s $tmp /etc/postfix/$file; then
        cp $tmp /etc/postfix/$file
        $postmap /etc/postfix/$file
    fi
done

rm -f $tmp
