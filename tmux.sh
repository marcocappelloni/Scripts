#!/bin/sh

SESSNAME="my_session"

tmux new-session -d -s "$SESSNAME"
tmux rename-window -t "$SESSNAME":0 'main'
tmux send-keys -t "$SESSNAME":0 'btop' Enter
