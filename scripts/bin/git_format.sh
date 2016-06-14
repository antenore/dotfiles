#!/usr/local/bin/bash -
#===============================================================================
#
#          FILE: git_format.sh
#
#         USAGE: ./git_format.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Antenore Gatta (agat), agat@ch.ibm.com
#  ORGANIZATION:
#       CREATED: 06/02/2016 20:56
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error

format_log_entry ()
{
    read commit
    read date
    read summary
    local statnum=0
    local add=0
    local rem=0
    while true; do
        read statline
        if [ -z "$statline" ]; then break; fi
        ((statnum += 1))
        ((add += $(echo $statline | cut -d' ' -f1)))
        ((rem += $(echo $statline | cut -d' ' -f2)))
    done
    if [ -n "$commit" ]; then
        echo "$commit;$date;$summary;$statnum;$add;$rem"
    else
        exit 0
    fi
}

while true; do
    format_log_entry
done


