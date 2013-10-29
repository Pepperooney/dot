#!/bin/bash

tmux new-window -n "${*}" "ssh $1"

shift

c=1
while [ $# -gt 0 ]; do
    (( c++ ))
    tmux split-window -d "ssh $1";
    tmux select-layout tiled
    tmux select-pane -t $c
    shift
done
tmux set-window-option synchronize-panes
tmux select-layout tiled
tmux select-pane -t 1
