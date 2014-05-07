#!/usr/bin/zsh

host="irccloud.com"
u="$(grep "machine $host .*login " ~/.netrc | awk '{print $4}')"
p="$(grep "machine $host .*login $usr" ~/.netrc | awk '{print $6}')"

json=~/bin/json.sh

t="$(curl -sX POST "https://www.irccloud.com/chat/auth-formtoken" | $json -b | awk '/token/{print $2}' | tr -d '"')"
s="$(curl -sd "email=$u" -d "password=$p" -d "token=$t" --header "x-auth-formtoken: $t" "https://www.irccloud.com/chat/login" | $json -b | awk '/session/{print $2}' | tr -d '"')"
