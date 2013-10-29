#!/bin/bash

# global
logfile=$HOME/log/mail2imap.log
folder=Archiv

# save mail
tmp=$(mktemp)
cat > $tmp

# init
y=$(date +%Y)

# backup to imap.mail.yahoo.com/Archive<year>
host=imap.mail.yahoo.com
usr=star.turtle@yahoo.de
pass="$(grep "machine $host .*login $usr" ~/.netrc | grep -o "password.*" | sed 's/password *//')"

echo -n "$(head -n 1 $tmp): " >> $logfile
mailtool -tofolder "$folder$y" -copyto "imaps://$usr:$pass@$host/novalidate-cert" mbox:$tmp >> $logfile

rm -f $tmp
