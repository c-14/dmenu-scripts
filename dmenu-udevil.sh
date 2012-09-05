#!/bin/bash

if [[ -f $HOME/.dmenurc ]]; then
	. $HOME/.dmenurc
else
	DMENU='dmenu -i'
fi

DEV_LABEL="/dev/disk/by-label/"

opt_mount_type=0
opt_ignore_filter=0
udevil_cmd="mount"

usage() {
	cat <<-EOF
		usage: dmenu-udevil [-mudih]
		 -m Mount devices
		 -u Unmount devices
		 -d Select by device rather than by label
		 -i Ignore filter and list all devices in /dev (with -d)
		 -h Print help
	EOF

}

dmenu_mnt() {
	if [[ $opt_mount_type -eq 1 ]]; then
		prompt="$udevil_cmd by-device:"
		if [[ $opt_ignore_filter -eq 0 ]]; then
			res="$(find /dev -maxdepth 1 -not -type d -name "s[dr]*" -or -name "hd*" | cut -d'/' -f3 | ${DMENU} -p "$prompt")"
		else
			res="$(find /dev -maxdepth 1 -not -type d | cut -d'/' -f3 | ${DMENU} -p "$prompt")"
		fi

		[[ -z $res ]] && echo "Cancelled." && exit
		udevil $udevil_cmd /dev/$res
	else
		prompt="$udevil_cmd by-label:"
		res="$(find $DEV_LABEL* | cut -d'/' -f5 | ${DMENU} -p "$prompt")"
		[[ -z $res ]] && echo "Cancelled." && exit
		udevil $udevil_cmd $DEV_LABEL/$res
	fi
}

while getopts ':mudhi' opt; do
	case "$opt" in
		m) ;;
		u) udevil_cmd="umount";;
		d) opt_mount_type=1;;
		i) opt_ignore_filter=1;;
		h) usage && exit;;
		/?) echo "Unrecognized command: $OPTARG";;
	esac
done

dmenu_mnt && exit
