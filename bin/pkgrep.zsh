pkgrep () { 
    egrep -hi "$*" ~/dl/publichd ~/dl/kickass | cut -d$'\t' -f1 |\
        sed 's/ /./g;s/\[[^]]*\]$//;s/\.m[pk][v4]//;s/\.$//' |\
        sort -u
}
