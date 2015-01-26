#!/bin/bash - 
#===============================================================================
#
#          FILE: dupe.sh
# 
#         USAGE: ./dupe.sh 
# 
#   DESCRIPTION: find duplicated files and do something with
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 07/09/2014 11:55
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

declare -A arr
shopt -s globstar

for file in **; do
  [[ -f "$file" ]] || continue

  read cksm _ < <(md5sum "$file")
  if ((arr[$cksm]++)); then 
    echo "rm $file"
  fi
done

