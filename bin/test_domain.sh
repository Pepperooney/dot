#!/bin/bash

domains=http://starturtle.eu.org/domains
uri=/
mail=admin

curl -s $domains | while read u; do
    curl -is $u$uri | grep -q "HTTP/1.1 200 OK"
    if [ $? -ne 0 ]; then
        swaks --to "$mail@$u" --from "domaincheck@starturtle.eu.org" --h-Subject "Check for $u failed" --body "$(curl -is $u$uri)"
    fi
done
