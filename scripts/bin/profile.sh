#!/usr/bin/env bash

: ${SCP:=/usr/bin/scp}
: ${AWK:=/usr/bin/nawk}
: ${CKSUM:=/usr/bin/cksum}

SSHARGS="-q" 


function chkstatus {
#
#   Args:
#       $1 = $server
#       $2 = $conf
#
#   The $conf file contain a list of server=number
#   the number is the first field of a cksum, like
#       2259686416      536     .bashrc
#
#   If we have a cksum, we compare it with the cksum of the file we want
#   to transfer
#===============================================================================

    [[ $# -ne 2 ]] && return 3          # means wrong number of args
    # match our server names
    [[ $1 =~ '[hz]sv[0-9]*s[.a-z]*' ]] && server=$1 
    [[ $1 =~ 'zadmi[0-9]*s[.a-z]*' ]] && server=$1
    [[ -f $2 ]] && conf=$2

    status=null
    $GREP $server $conf && status=`$AWK '{print $2}' $conf`

    [[ $status == null ]] && return 1   # means todo
    [[ $status == [0-9]* ]] && return 2 # means check cksum

    return 5                            # means something went wrong

}

function sendprodile {
#
#
#===============================================================================

    [[ $# -ne 2 ]] && return 3          # means wrong number of args
    [[ -f $1 ]] && file=$2              # our ".profile"
    # match our server names
    [[ $2 =~ '[hz]sv[0-9]*s[.a-z]*' ]] && server=$1                             
    [[ $2 =~ 'zadmi[0-9]*s[.a-z]*' ]] && server=$1   
    $SCP $SSHARGS $file $server:

}

function cksumfile {
#
#   used to chksum the ".profile" 
#
#===============================================================================

    [[ $# -ne 1 ]] && return 3          # means wrong number of args
    [[ -f $1 ]] && file=$1

    checksum=`$CKSUM $file | $AWK '{print $1}'`

}
