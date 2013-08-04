#!/bin/bash

if [[ -f $HOME/.dmenurc ]]; then
    . $HOME/.dmenurc
else
    DMENU='dmenu -i'
fi

attach="$HOME/.tmux/tmux-attach"

# sessions that will always be displayed
tmux_pre="hub irc src"

# sessions that are active
tmux_run="$(tmux list-sessions -F '#S')"

prompt="tmux:"

spawn() {
    urxvtc -name "$1" -e bash -c "$attach $1"
}

target=$(echo $tmux_pre $tmux_run | sed 's/ /\n/g' | sort -u | ${DMENU} -p "$prompt")


[[ -n $target ]] && spawn $target
