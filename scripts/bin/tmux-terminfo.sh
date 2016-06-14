#!/bin/bash -
#===============================================================================
#
#          FILE: tmux-terminfo.sh
#
#         USAGE: ./tmux-terminfo.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Antenore Gatta (agat), agat@ch.ibm.com
#  ORGANIZATION:
#       CREATED: 05/06/2015 11:43
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error


screen_terminfo="screen-256color"
infocmp "$screen_terminfo" | sed -e 's/^screen[^|]*|[^,]*,/screen-it|screen with italics support,/' -e 's/%?%p1%t;3%/%?%p1%t;7%/' -e 's/smso=[^,]*,/smso=\\E[7m,/' -e 's/rmso=[^,]*,/rmso=\\E[27m,/' -e '$s/$/ sitm=\\E[3m, ritm=\\E[23m,/' > /tmp/screen.terminfo
tic /tmp/screen.terminfo
sudo tic /tmp/screen.terminfo

# ADD set -g default-terminal "screen-it" inside tmux.conf


