#!/bin/bash

category="14"
search="1080p"

curl -ks 'https://publichd.se/index.php?page=torrents&search=1080p&active=1&category=14' | sed -n 's/^.*title=.View details: \([^"]*\).*/\1/p' | tac
