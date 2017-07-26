#!/bin/bash -
#===============================================================================
#
#          FILE: ilock.sh
#
#         USAGE: ./ilock.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (),
#  ORGANIZATION:
#       CREATED: 07/26/2017 11:46:04 PM
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

revert() {
    xset dpms 0 0 0
}

trap revert HUP INT TERM
xset +dpms dpms 5 5 5
i3lock -n -c 000000
revert
