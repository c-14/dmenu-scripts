dmenu-scripts
=============

### Synopsis
This repository contains wrapper scripts for everyday programs I
want to use in conjunction with dmenu.

### Requirements
The requirements are script-specific. Usually, the name of the script
implies its requirement programs (e.g dmenu-udevil needs udevil).

Any special requirements are listed in the corresponding script
section.

### Download
Clone the repo with git:
`git clone git://github.com/vehk/dmenu-scripts.git`

### Usage
Pretty much a no-brainer: just run the script.
Get script-specific help by passing the '-h' flag to the script.

### dmenu
Get [dmenu](http://tools.suckless.org/dmenu).

In order to centralize your dmenu configuration, my scripts source
`.dmenurc` in $HOME.
The configuration file contains the DMENU variable that specifies
which parameters dmenu is run with. Here is an example:
`DMENU="dmenu -i -fn -*-terminus-medium-r-*-*-16-*-*-*-*-*-*-* -nb #3F3F3F -nf #DCDCCC -sb #1E2320 -sf #F0DFAF"`

### Scripts

#### dmenu-udevil
This script uses udevil in order to mount external devices without
root access. The default behaviour is to mount devices by label
found in `/dev/disk/by-label/`.

By passing the '-d' flag, you can instead mount devices found in /dev.
Here, the script tries to find all SATA/IDE devices `s[dr]* or hd*` in
order to cut down the length of arguments passed to dmenu and to
remove nonsensical devices (such as `/dev/null`).
Pass the '-i' flag to instead list all devices in /dev.

You can also pass all output from udevil to notify-send by passing the '-n'
flag.

### License
These scripts are considered public domain. Do whatever you want with
them.
