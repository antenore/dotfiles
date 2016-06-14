#!/bin/bash
#===============================================================================
#
#          FILE:  cal.sh
#
#         USAGE:  ./cal.sh
#
#   DESCRIPTION:  Dzen calendar
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Antenore Gatta (),
#       COMPANY:  IBM Switzerland
#       VERSION:  1.0
#       CREATED:  23. 10. 12 16:08:42 CEST
#      REVISION:  ---
#===============================================================================

TODAY=$(expr `date +'%d'` + 0)
MONTH=`date +'%m'`
YEAR=`date +'%Y'`

(
echo '^bg(#222222)^fg(#DE8834)'`date +'%d %b %H.%M'`;

# current month, hilight header and today
cal | sed -re "s/^(.*[A-Za-z][A-Za-z]*.*)$/^fg(#DE8834)^bg(#222222)\1/;
s/(^|[ ])($TODAY)($|[ ])/\1^bg(#DE8834)^fg(#222222)\2^fg(#6c6c6c)^bg(#222222)\3/"
sleep 8
) | dzen2 -p 60 -fg '#c8e7a8' -bg '#1a1a1a' -fn '-*-tamsyn-medium-*-*-*-12-*-*-*-*-*-iso10646-*' -x 3000 -y 15 -w 180 -l 20 -sa c -e 'onstart=uncollapse;button3=exit'
