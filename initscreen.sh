#!/bin/sh
#
# Example xrandr multiscreen init

#xrandr --output LVDS --auto
#xrandr --output VGA --auto --right-of LVDS

#xrandr --output HDMI1 --off --output LVDS1 --mode 1600x900 --pos 160x1080 \
       #--rotate normal --output DP1 --off --output VGA1 --mode 1920x1080  \
       #--pos 0x0 --rotate normal

xrandr --output LVDS1 --mode 1600x900 --pos 0x180 --rotate normal \
       --output VGA1 --mode 1920x1080 --pos 1600x0 --rotate normal

