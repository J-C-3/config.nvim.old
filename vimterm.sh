#!/usr/bin/env bash

mkdir /tmp/tmux-vimterm 2>/dev/null

session=0

TMUX_ARGS=(-S /tmp/tmux-vimterm/vimterm -L vimterm)

if tmux ${TMUX_ARGS[@]} ls 2>/dev/null; then
    # close all unattached first
    IFS=$'\n'
    currentSessions=($(tmux ${TMUX_ARGS[@]} ls))
    for s in ${currentSessions[@]}; do
        if echo $s | grep attached; then
            continue
        fi

        tmux ${TMUX_ARGS[@]} kill-session -t $(echo $s | cut -d ":" -f1)
    done

    currentSessions=($(tmux ${TMUX_ARGS[@]} ls))
    for s in ${currentSessions[@]}; do
        if echo "$s" | grep -i "vimterm[0-9]" > /dev/null; then
            if tmux ${TMUX_ARGS[@]} -f ~/.config/tmux/vimterm.conf ls -F '#{session_name}' | grep "vimterm$session" > /dev/null; then
                session=$((session + 1))
            else
                break
            fi
        fi
    done
fi

tmux ${TMUX_ARGS[@]} -f ~/.config/tmux/vimterm.conf new-session -d -s vimterm$session
tmux ${TMUX_ARGS[@]} a -t vimterm$session
