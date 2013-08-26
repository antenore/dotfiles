#!/bin/bash

[[ $# -eq 0 ]] && { echo "Provide a file name" ; exit 1 ;}
[[ ! -f $1 ]] && { echo "$1 it's not a regular file " ; exit 1 ; }

LINES=`wc -l $1 | awk '{ print ($1 + 1) }'`
RANDSEED=`date '+%S%M%I'`
LINE=`cat $1 | awk -v COUNT=$LINES -v SEED=$RANDSEED 'BEGIN { srand(SEED); \
    i=int(rand()*COUNT) } FNR==i { print $0 }'`
echo $LINE
