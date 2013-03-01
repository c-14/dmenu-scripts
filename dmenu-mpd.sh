#!/bin/bash

if [[ -f $HOME/.dmenurc ]]; then
    . $HOME/.dmenurc
else
    DMENU='dmenu -i'
fi

prompt="mpc:"
prompt_add="$prompt-add:"

cmd_list="play stop next prev toggle add volume seek repeat single consume random clear crop"

mpc_add() {
    file="$(mpc listall | ${DMENU} -l 15 -p "$prompt_add")"
    [[ -z $file ]] && exit 1
    mpc add "$file"
}

cmd="$(echo $cmd_list | sed 's/ /\n/g' | ${DMENU} -p "$prompt")"
[[ -z $cmd ]] && exit 1

if [[ $cmd = add ]]; then
    mpc_add
else
    mpc $cmd
fi

