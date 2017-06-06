#!/bin/bash

DMENU=${DMENU:-dmenu}

TERMCMD=${TERMCMD:-xterm}

PWLIST="$HOME/.pwlist"

PROMPT="pwsafe $@"

item=$(eval ${DMENU} -p \""$PROMPT\"" < "$PWLIST")

[[ -z $item ]] && exit 1

${TERMCMD} -name pass -e pwsafe $@ "$item" --
