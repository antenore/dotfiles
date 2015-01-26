#!/bin/bash - 
#===============================================================================
#
#          FILE: temp-report-BSNI.sh
# 
#         USAGE: ./temp-report-BSNI.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 05/14/2014 17:52
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

sleep 10

ping -c10 129.35.232.61

ping -c10 129.35.232.32

traceroute 129.35.232.61

traceroute 129.35.232.32

