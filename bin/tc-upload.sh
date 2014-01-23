#!/bin/bash
host=www.torrentcloud.eu
uri=/cp/
usr="$(grep "machine $host .*login " ~/.netrc | awk '{print $4}')"
pass="$(grep "machine $host .*login $usr" ~/.netrc | awk '{print $6}')"

curl -o /dev/null -k --form "file=@$1" --form "cmdSend=Run" --form "slots=0" "https://$usr:$pass@$host$uri"
echo "$1 uploaded (hopefully, haven't checked)"
