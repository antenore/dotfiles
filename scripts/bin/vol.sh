#!/bin/bash - 
#===============================================================================
#
#          FILE: vol.sh
# 
#         USAGE: ./vol.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 06/03/2014 17:07
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

mute=`amixer sget Master | grep "Front Left:" | awk '{print $6}'`
if [ $mute == "[on]" ]
then
    vol=`amixer get Master | grep "Front Left:" | awk '{print $5}' | tr -d '[]'`
    if [ $vol == "0%" ]
    then 
        echo "Mute"
    else
        echo $vol
    fi
else
    echo "Mute"
fi

