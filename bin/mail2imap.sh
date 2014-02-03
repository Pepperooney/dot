#!/bin/bash

# global
folder=Archiv

# backup to imap.mail.yahoo.com/Archive
host=imap.mail.yahoo.com
usr=star.turtle@yahoo.de
pass="$(grep "machine $host .*login $usr" ~/.netrc | grep -o "password.*" | sed 's/password *//')"

# save mail
tmp=$(mktemp)
cat > $tmp

mailtool -tofolder "$folder" -copyto "imaps://$usr:$pass@$host/novalidate-cert" mbox:$tmp

rm -f $tmp
