#!/bin/bash

phd=/Volumes/media/dl/publichd
tc=~/dot/bin/torrentcloud.sh

$tc add "$(grep -h "$*" $phd | head -n 1 | cut -d$'\t' -f2-)"                                                 
