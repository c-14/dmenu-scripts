#!/bin/bash

if [[ -f $HOME/.dmenurc ]]; then
    . $HOME/.dmenurc
else
    DMENU='dmenu -i'
fi

TERMCMD=${TERMCMD:-xterm}

PWLIST="$HOME/.pwlist"

PROMPT="pwsafe $@"

item=$(${DMENU} -p "$PROMPT" < "$PWLIST")

[[ -z $item ]] && exit 1

${TERMCMD} -name pass -e pwsafe $@ "$item" --
