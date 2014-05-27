pkgrep () { 
    egrep -hi "$*" /Volumes/media/dl/publichd | cut -d$'\t' -f1 |\
        sed 's/ /./g;s/\[[^]]*\]$//;s/\.m[pk][v4]//;s/\.$//' |\
        sort -u
}
