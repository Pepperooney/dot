#!/bin/bash

p=/srv
depth=1
dest=/srv/starturtle.eu.org/domains

find "$p" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" > "$dest"
