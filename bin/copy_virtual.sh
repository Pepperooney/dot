#!/bin/bash

tmp=$(mktemp)

if ! curl -so $tmp http://starturtle.eu.org/virtual; then
    exit 1
fi
cp $tmp /etc/postfix/virtual
rm -f $tmp
/usr/sbin/postmap /etc/postfix/virtual
