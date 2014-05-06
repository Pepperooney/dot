#!/bin/bash

phd=~/dl/publichd
kick=~/dl/kickass
tc=~/bin/torrentcloud.sh

$tc add "$(grep -h "$*" $phd $kick | head -n 1 | cut -d$'\t' -f2-)"                                                 
