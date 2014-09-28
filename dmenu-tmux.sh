#!/bin/bash

if [[ -f $HOME/.dmenurc ]]; then
    . $HOME/.dmenurc
else
    DMENU='dmenu -i'
fi

if [[ -f $HOME/.tmux/attach.list ]]; then
    . $HOME/.tmux/attach.list
fi

ssh_chain() {
    if [[ -f $HOME/.keychain/$HOSTNAME-sh ]]; then
        . $HOME/.keychain/$HOSTNAME-sh
    fi
}

if [[ $1 == "-r" ]]; then

    attach="$HOME/.tmux/tmux-attach-remote"
    ssh_prompt="target:"

    while true; do
        ssh_target=$(echo $ssh_pre | sed 's/ /\n/g' | ${DMENU} -p "$ssh_prompt")

        # this works for keychain, ssh-agent and gpg-agent are untested.
        # Should be fine if you use x11-ssh-askpass or pinentry with gtk
        # This is needed in case dmenu-tmux is started without a
        # controlling terminal.
        ssh_chain

        [[ -z $ssh_target ]] && exit
        tmux_run="$(ssh $ssh_target "tmux list-sessions -F \#S")"

        [[ $? -eq 0 ]] && break
    done

    prompt="attach-remote:"

else

    attach="$HOME/.tmux/tmux-attach"

    tmux_run="$(tmux list-sessions -F '#S')"

    prompt="attach-local:"

fi

spawn_local() {
    urxvtc -name "$1" -e bash -c "$attach $1"
}

spawn_remote() {
    urxvtc -name "$1" -e bash -c "$attach $1 $2"
}

target=$(echo $tmux_pre $tmux_run | sed 's/ /\n/g' | sort -u | ${DMENU} -p "$prompt")

if [[ -n $target ]]; then
    if [[ $1 == "-r" ]]; then
        spawn_remote $ssh_target $target
    else
        spawn_local $target
    fi
fi
