#!/bin/sh
#


screenshot() {
	case $1 in
	full)
		scrot -m '%Y-%m-%d_$wx$h_full.png' -e 'mv $f ~/shots/'
		;;
	window)
		sleep 1
		scrot -s '%Y-%m-%d_$wx$h_window.png' -e 'mv $f ~/shots/'
		;;
	*)
		;;
	esac;
}

[[ ! -d ~/shots/ ]] && mkdir ~/shots/
screenshot $1
