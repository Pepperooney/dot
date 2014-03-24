#!/bin/bash

phd=~/dl/publichd
kick=~/dl/kickass

torrentcloud.sh add "$(grep -h "$*" $phd $kick | cut -d$'\t' -f2-)"                                                 
