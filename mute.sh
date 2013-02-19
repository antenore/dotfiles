#!/bin/bash
#===============================================================================
#
#          FILE:  mute.sh
# 
#         USAGE:  mute.sh 
# 
#   DESCRIPTION:  To mute unmute the audio from the command line
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Antenore Gatta (), 
#       COMPANY:  IBM Switzerland
#       VERSION:  1.0
#       CREATED:  10/20/2012 06:53:53 PM CEST
#      REVISION:  ---
#===============================================================================
#set -x
# The first time I consider the sound is unmute

[ ! -f $HOME/.*mute ] && { amixer set Master mute; touch ~/.mute; exit;}

# Then I mute or unmute based on wich file we have
[ -f $HOME/.mute ] && { amixer set Master unmute;     \
                        amixer set Speaker unmute;    \
                        amixer set  Headphone unmute; \
                        mv ~/.mute ~/.unmute; exit; }
[ -f $HOME/.unmute ] && { amixer set Master mute; mv ~/.unmute ~/.mute; exit; }


