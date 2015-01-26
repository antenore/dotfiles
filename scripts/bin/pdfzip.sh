#!/usr/bin/env bash

[[ $# -ne 1 ]] && { echo "You must supply the PDF file name" ; exit 1 ; }

[[ ! -f $1 ]] && { echo "$1 is not a regular file" ; exit 1 ; }

PDF=$1
PDFOUTDIR=~/PDF

# NO NEW LINES with gs!!!!!
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$PDFOUTDIR/OUT_$1 $1

[[ $? -eq 0 ]] && echo "$PDFOUTDIR/OUT_$1 written succesfully"
