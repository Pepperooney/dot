#!/bin/bash

torrentcloud.sh add "$(grep "$*" ~/dl/publichd | cut -d$'\t' -f2-)"                                                 
