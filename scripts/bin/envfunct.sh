#!/usr/bin/env bash

################################################################################
#                                                                              #
#                                  CONSTANTS                                   #
#                                                                              #
################################################################################

function isSunOS {
#
# isSunOS defines the commands, aliases and prompt specific to SunOS
#
#===============================================================================

    : ${PRINT:=print}

}

function isLinux {
#
# isLinux defines the commands, aliases and prompt specific to Linux
#
#===============================================================================

    : ${PRINT:=echo}

}

function isAIX {
#
# isLinux defines the commands, aliases and prompt specific to AIX
#
#===============================================================================
    
    : ${PRINT:=echo}

}

function isKSH {
#
# isKSH defines the commands, aliases and prompt specific to the Korn Shell
#
# Needs:
#       COLOR, BLUE, CYAN, WHITE, HOST
#
#       HOST=`hostname`
#       COLOR="$GREEN"
#       GREEN="\\033[01;32m"
#       BLUE="\\033[01;34m"
#       CYAN="\\033[01;36m"
#       WHITE="\\033[0m"
#       END="\$"
#       if [ "$LOGNAME" = "root" ]; then
#           COLOR="$RED"
#           END="# "
#       fi
#
#===============================================================================
 
    # export functions
    : ${FNEXP:=typeset -fx}

    # Prompt
    PS1="$(echo ${BLUE})${HOST%%.*}:$(echo $CYAN$){PWD}$(echo \"\\n\")\
$(echo $COLOR$){USER}$(echo ${WHITE}) $END "

}
function isBASH {  
#
# isBASH defines the commands, aliases and prompt specific to the Korn Shell
#
# Needs:
#       COLOR, BLUE, CYAN, WHITE, HOST
#
#       HOST=`hostname`
#       COLOR="$GREEN"
#       GREEN="\\033[01;32m"
#       BLUE="\\033[01;34m"
#       CYAN="\\033[01;36m"
#       WHITE="\\033[0m"
#       END="\$"
#       if [ "$LOGNAME" = "root" ]; then
#           COLOR="$RED"
#           END="# "
#       fi
#
#===============================================================================
 
    # export functions
    : ${FNEXP:=export -f}

    PS1="$(echo ${BLUE})${HOST%%.*}:$(echo $CYAN$){PWD}$(echo "\n")\
$(echo $COLOR$){USER}$(echo ${WHITE}) $END "

}

function chkos {

    ostype=`uname -s`
    [[ -z $ostype ]] && { echo "Cannot evaluate OS"; return; }
    [[ $ostype = "SunOS" ]] && { isSunOS; return; }
    [[ $ostype = "Linux" ]] && { isLinux; return; }
    [[ $ostype = "AIX" ]] && { isAIX; return; }
    [[ -n $ostype ]] && { echo "OS $ostype not supported" ; return; }
    
}

function chkshell  {

    shell=`ps -p $$ -o fname | tail -1`
    [[ -z $shell ]] && { echo "Cannot evaluate the shell"; return; }
    [[ $shell = bash ]] && { isBash; return; }
    [[ $shell = ksh ]] && { isKSH; return; }
    [[ -n $shell ]] && { echo "Shell $shell not supported"; return; }

}

