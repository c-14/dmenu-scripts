dmenu-scripts
=============

## Synopsis
This repository contains wrapper scripts for everyday programs I
want to use in conjunction with dmenu.

## Requirements
The requirements are script-specific. Usually, the name of the script
implies its required programs (e.g dmenu-udevil needs udevil).

Any special requirements are listed in the corresponding script
section.

## Download
Clone the repo with git:
`git clone git://github.com/vehk/dmenu-scripts.git`

## Usage
Pretty much a no-brainer: just run the script.
Get script-specific help by passing the '-h' flag to the script.

## dmenu
Get [dmenu](http://tools.suckless.org/dmenu).

In order to centralize your dmenu configuration, my scripts source
`.dmenurc` in $HOME.
The configuration file contains the DMENU variable that specifies
which parameters dmenu is run with. Here is an example:

```bash
DMENU="dmenu -i -fn -*-terminus-medium-r-*-*-16-*-*-*-*-*-*-* -nb #3F3F3F -nf #DCDCCC -sb #1E2320 -sf #F0DFAF"
```

## Scripts

### dmenu-udevil
This script uses udevil in order to mount external devices without
root access. The default behaviour is to mount devices by label
found in `/dev/disk/by-label/`.

By passing the '-d' flag, you can instead mount devices found in /dev.
Here, the script tries to find all SATA/IDE devices (s[dr]\* or hd\*) in
order to cut down the length of arguments passed to dmenu and to
remove nonsensical devices (such as /dev/null).
Pass the '-i' flag to instead list all devices in /dev.

You can also pass all output from udevil to notify-send by passing the '-n'
flag.

### dmenu-mpd
A very small dmenu wrapper around mpc that provides access to the most common
actions I perform on a daily basis.

The `add` command will launch another dmenu instance in which you can select a
single song that is then added to the current playlist.
I do not intend to include commands that add a range of songs, as this should
really be up to your favourite mpd client.

Note that some of the commands need additional parameters (e.g `volume` and `seek`).
See the mpc manpage for more documentation about the commands and parameters.

### dmenu-tmux
Wraps around tmux-attach scripts in vehk/dotfiles.

dmenu-tmux sources `~/.tmux/attach.list` for session that should be
displayed by default. For example:

```bash
tmux_pre="mail misc mpd irc" # default tmux sessions
```
When invoked with no arguments, dmenu-tmux will attach to a local tmux
session using tmux-attach.

### dmenu-pwsafe
A wrapper around the cli password manager `pwsafe`. After selecting
an entry with dmenu, the script opens up a terminal window and runs
`pwsafe` with the options passed to dmenu-pwsafe.

As `pwsafe` does not provide an unencrypted list of its password
entries, dmenu-pwsafe requires a pre-compiled list that can be generated
with `pwsafe --list > ~/.pwlist`.

The `TERMCMD` variable specifies which terminal emulator to start; when
empty, dmenu-pwsafe defaults to `xterm`.

## License
These scripts are considered public domain. Do whatever you want with
them.
