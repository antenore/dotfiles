#!/bin/sh

#
# ~/.xsession
#
# Executed by xdm/gdm/kdm at login
#

/bin/bash --login -i ~/.xinitrc

gnome-settings-daemon 2>/dev/null &      # handles themes, starts gnome-screensaver. You may have to use gconf to disable it setting the background.
gnome-power-manager 2>/dev/null &        # for laptops and stuff
gnome-volume-manager 2>/dev/null &       # for mounting CDs, USB sticks, and such
eval `gnome-keyring-daemon`  # SSH/GPG agent
[[ $(xrandr | grep " connected " | wc -l ) -eq 2 ]] && exec .screenlayout/dual-external.sh
xrdb ~/.Xresources
urxvt256cd -q -o -f
xcompmgr -cCfF -t-5 -l-5 -r4.2 -o.55 -D2 &
