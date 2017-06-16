#!/bin/bash

DMENU=${DMENU:-dmenu}

if [[ -f $HOME/.tmux/attach.list ]]; then
    . $HOME/.tmux/attach.list
fi

attach="$HOME/.tmux/tmux-attach"

tmux_run="$(tmux list-sessions -F '#S')"

prompt="attach-local:"

spawn_local() {
    urxvtc -name "$1" -e bash -c "$attach $1"
}

target=$(echo $tmux_pre $tmux_run | sed 's/ /\n/g' | sort -u | eval ${DMENU} -p "$prompt")

if [[ -n $target ]]; then
    spawn_local $target
fi
