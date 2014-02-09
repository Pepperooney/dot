#!/bin/bash

curl -s 'http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=3' | ~/bin/json.sh -b | awk '/lasttradeprice/{print substr($2,2,length($2)-2)}'
