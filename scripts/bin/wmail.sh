#!/bin/bash - 
#===============================================================================
#
#          FILE: wmail.sh
# 
#         USAGE: ./wmail.sh 
# 
#   DESCRIPTION: mailx wrapper
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Antenore Gatta
#  ORGANIZATION: IBM
#       CREATED: 02/18/2014 17:21
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

PROGNAME=$(basename $0)

# Simple email
#echo "mailtext" | mailx -r $FROM -s "$1" -c "$TOWME; $TOAMS" $TOMON
# Simple long email
#cat bodyfile.txt | mailx -r $FROM -s "$1" -c "$TOWME; $TOAMS" $TOMON
# Attachment
#uuencode attachfile attachfile | mailx -r $FROM -s "$1" -c "$TOWME; $TOAMS" $TOMON
#Attachment with body
#(cat bodyfile.txt uuencode attachfile attachfile) | mailx -r $FROM -s "$1" -c "$TOWME; $TOAMS" $TOMON

if (($# == 0)); then
  echo ""
  echo "$PROGNAME -t mail1 -c mail2 -s subject -b 'body' -f file"
  echo ""
  echo "    Options:"
  echo ""
  echo "    -t  to"
  echo "    -c  cc"
  echo "    -s  subject"
  echo "    -b  body"
  echo "    -f  filename"
  echo ""
  echo "    Example:"
  echo ""
  echo "    $PROGNAME -t mail@example.com -c mail2@example.com -s hello -b 'all done' -f wmail.sh"
  exit
fi
while getopts ":t:c:s:b:f:" opt; do
  case $opt in
    t)
      echo "to: $OPTARG" >&2
      to=$OPTARG
      ;;
    c)
      echo "cc: $OPTARG" >&2
      cc=$OPTARG
      ;;
    s)
      echo "subj: $OPTARG" >&2
      subj=$OPTARG
      ;;
    b)
      echo "body: $OPTARG" >&2
      body=$OPTARG
      ;;
    f)
      echo "filename: $OPTARG" >&2
      filename=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done
