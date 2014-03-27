#!/bin/bash

phd=~/dl/publichd
kick=~/dl/kickass

torrentcloud.sh add "$(grep -h "$*" $phd $kick | head -n 1 | cut -d$'\t' -f2-)"                                                 
