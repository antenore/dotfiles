#!/bin/bash
# Building the status bar for my computer - output to i3bar (JSON)

# Defined Constants for this script
readonly BIGSPACE="          "
readonly OPEN='{ "full_text": "'
readonly COLORGOOD='", "color": "#209FFC"'
readonly COLORMED='", "color": "#20E7F0"'
#readonly COLORBAD='", "color": "#DBB84A"'
# More greenish tint to color-bad, so it's not as bright on the screen
readonly COLORBAD='", "color": "#9AF86A"'
readonly COLORFATAL1="$BIGSPACE"'", "color": "#FF0313"'
readonly COLORFATAL2='", "color": "#FF03F7"'
readonly CLOSE=' }'
readonly GOOD="0"
readonly MED="1"
readonly BAD="2"
readonly FATAL="3"
readonly NOPRINT="4"
readonly EMPTYFIELD=$OPEN" "$COLORGOOD$CLOSE
readonly LARGESEPARATOR=$OPEN$BIGSPACE" "$COLORGOOD$CLOSE

# How often to reset the counter - ideally set to LCM of all the above values (needs to be for initial output)
RESETCYCLES=300
CYCLES=RESETCYCLES

# For making it so we can switch the two colors of a bad state (flashing bad-state colors)
COLORFATAL=$COLORFATAL1
FATALCOLOR=0

# Variables containing the data in JSON format to be output
DATETIME="$EMPTYFIELD"
#NEXTAPPT="$EMPTYFIELD"
NEXTTASK="$EMPTYFIELD"
BATTERY="$EMPTYFIELD"
VOLUME="$EMPTYFIELD"
MEDIA="$EMPTYFIELD"
UPDATES="$EMPTYFIELD"
UPTIME="$EMPTYFIELD"
DISKUSE="$EMPTYFIELD"
CPUTEMP="$EMPTYFIELD"

# The state of each thing being output to the status bar
STATEDATETIME="$MED"
#STATENEXTAPPT="$MED"
STATENEXTTASK="$MED"
STATEBATTERY="$MED"
STATEVOLUME="$MED"
STATEMEDIA="$NOPRINT"
STATEUPDATES="$MED"
STATEUPTIME="$MED"
STATEDISKUSE="$MED"
STATECPUTEMP="$MED"

# Names/identities of each field (for click identification
readonly NAMEDATETIME='", "name": "date'
#readonly NAMENEXTAPPT='", "name": "nextappt'
readonly NAMENEXTTASK='", "name": "nexttask'
readonly NAMEBATTERY='", "name": "battery'
readonly NAMEVOLUME='", "name": "volume'
readonly NAMEMEDIA='", "name": "media'
readonly NAMEUPDATES='", "name": "updates'
readonly NAMEUPTIME='", "name": "uptime'
readonly NAMEDISKUSE='", "name": "diskuse'
readonly NAMECPUTEMP='", "name": "cputemp'

# Set how much to sleep each cycle, and how often each field is updated (in cycles of this program, not in seconds)
SLEEPTIME="2"
CYCDATETIME=15
#CYCNEXTAPPT=60
CYCNEXTTASK=60
CYCBATTERY=3
CYCVOLUME=2
CYCMEDIA=4
CYCUPDATES=300
CYCUPTIME=30
CYCDISKUSE=300
CYCCPUTEMP=1

## Function definitions for setting strings/states
# Battery info
function set_battery() {
    # Default output
    BATTERY="B: U"
    STATEBATTERY="$MED"
    
    # Check if the battery is present
    local BATPRES=""
    read BATPRES < /sys/class/power_supply/BAT0/present
    if [ "$BATPRES" == "0" ]
    then
        BATTERY="B: Not Present"
        STATEBATTERY="$MED"
    else
        # Read in the battery state from ACPI
        local BATLINE=$( acpi -b )
    
        # Pull out the charging/discharging/full state
        local BATSTATUS=$( echo "$BATLINE" | awk '{printf substr($3, 1, 1)}' )
        BATTERY="B: $BATSTATUS"
        STATEBATTERY="$GOOD"
    
        # If it's charging/discharging, pull out the percentage and time until finished
        if [ "$BATSTATUS" == "C" -o "$BATSTATUS" == "D" ]
        then 
            local BATTIME="$( echo $BATLINE | awk -F , '{printf substr($3, 2, 5)}' )"
            BATTERY=$BATTERY"$( echo $BATLINE | awk -F , '{printf $2}' )"
            BATTERY="$BATTERY $BATTIME"
    
            # Check if the battery is close to being dead
            if [ "$BATSTATUS" == "D" ]
            then
                BATTIME="$( echo "$BATTIME" | awk -F : '{mins = 60 * $1 + $2; printf mins}' )"
                if [ "$BATTIME" -lt "15" ]
                then
                    STATEBATTERY="$FATAL"
                elif [ "$BATTIME" -lt "30" ]
                then
                    STATEBATTERY="$BAD"
                elif [ "$BATTIME" -lt "45" ]
                then
                    STATEBATTERY="$MED"
                fi
            fi
        elif [ "$BATSTATUS" == "U" ]
        then
            BATTERY="$BATTERY ($( echo "$BATLINE" | awk -F , '{printf substr($2,2)}' ))"
            STATEBATTERY="$MED"
        elif [ "$BATSTATUS" == "F" ]
        then
            BATTERY="$BATTERY ($( acpi -i | awk -F = '{printf substr($2,2)}' ))"
            STATEBATTERY="$GOOD"
        fi
    fi
}

# Volume info
function set_volume() {
    # Get the volume state
    local VOLLINE=$( amixer get Master | awk '/%/ {printf $6 $4}' )
    local VOLSTATUS=${VOLLINE:1:3}
    VOLUME=${VOLLINE:5:(-1)}
    STATEVOLUME="$GOOD"
    if [ "$VOLSTATUS" == "off" ]
    then
        VOLUME="M (${VOLUME:1})"
        STATEVOLUME="$MED"
    fi
    VOLUME="V: $VOLUME"
}

# Media info (mpv player)
function set_media() {
    # Check if the fifo exists for our queued mpv player
    local MPV_FIFO_EXP="/tmp/umpv-fifo-$USER"
    if [[ "$(ps -u $USER | grep umpv | wc -l)" -eq "0" || ! -p "$MPV_FIFO_EXP" ]]
    then
        MEDIA="M: None"
        STATEMEDIA="$NOPRINT"
        return
    fi

    # Media is playing
    MEDIA="M:"
    
    # set the stdout file
    local MPV_STDOUT_EXP="/tmp/umpv-stdout-$USER.*"
    # Tell mpv to output the time and name to the fifo (race condition here, may not output before we read)
    local STATE="$( tail -n1 $MPV_STDOUT_EXP )"
    STATEMEDIA="$GOOD"
    if [[ "${STATE:0:3}" == "yes" ]]
    then
        MEDIA="$MEDIA (P)"
        STATE="${STATE:4}"
        STATEMEDIA="$MED"
    elif [[ "${STATE:0:2}" == "no" ]]
    then
        STATE="${STATE:3}"
        STATEMEDIA="$GOOD"
    else
        STATE="-"
        STATEMEDIA="$BAD"
    fi
    MEDIA="$MEDIA $STATE"
}

# Updates info
function set_updates() {
    # List the number of updates from the pacman local repo
    # Requires a cron job downloading new repo-lists and stuff as root
    UPDATES="$( pacman -Qu | wc -l )"
    STATEUPDATES="$GOOD"
    if [ "$UPDATES" -gt "30" ]
    then
        STATEUPDATES="$BAD"
    elif [ "$UPDATES" -gt "10" ]
    then
        STATEUPDATES="$MED"
    fi
    UPDATES="PM: $UPDATES"
}

# Uptime info
function set_uptime() {
    # uptime outputs in a retarded format, have to do a bit of processing ourselves
    declare -a UPOUTPUT=($( uptime -p ))
    STATEUPTIME="$GOOD"
    UPTIME="UT:"
    local i=2
    while [ "$i" -lt "${#UPOUTPUT[@]}" ]
    do
        local UPUNIT=${UPOUTPUT[$i]:0:1}
        local UPAMOUNT=${UPOUTPUT[(($i-1))]}
        if [ "$UPUNIT" == "d" ]
        then
            if [ "$UPAMOUNT" -ge "4" ]
            then
                STATEUPTIME="$BAD"
            fi
            if [ "$UPAMOUNT" -ge "2" ]
            then
                STATEUPTIME="$MED"
            fi
        fi 
        UPTIME="$UPTIME $UPAMOUNT$UPUNIT"
        let i=$i+2
    done
}

# Disk info
function set_diskuse() {
    # Get all the data
    declare -a DF=($( df | awk '/sda/ {printf $4" "}' ))
    
    # Set the proper state for the root drive
    STATEDISKUSE="$GOOD"
    if [ "${DF[0]}" -lt "800000" -o "${DF[1]}" -lt "5000000" ]
    then
        STATEDISKUSE="$BAD"
    elif [ "${DF[0]}" -lt "1500000" -o "${DF[1]}" -lt "15000000" ]
    then
        STATEDISKUSE="$MED"
    fi
    DISKUSE="$( echo ${DF[0]} | awk '{human=$1/1000000; printf("/: %1.1fG", human)}' )"
    DISKUSE="$DISKUSE, $( echo ${DF[1]} | awk '{human=$1/1000000; printf("/home: %1.1fG", human)}' )"
}

# CPU info
function set_cputemp() {
    CPUTEMP="$( acpi -t | awk '{printf $4+0}' )"
    STATECPUTEMP="$GOOD"
    if [ "$CPUTEMP" -gt "70" ]
    then
        STATECPUTEMP="$FATAL"
    elif [ "$CPUTEMP" -gt "62" ]
    then
        STATECPUTEMP="$BAD"
    elif [ "$CPUTEMP" -gt "52" ]
    then
        STATECPUTEMP="$MED"
    fi
    CPUTEMP="CPU-T: $CPUTEMP°C"
}

# Next task item
function set_nexttask() {
    local TASK="$( task limit:1 next )"
    NEXTTASK="T:"
    STATENEXTTASK="$GOOD"
    if [ "$TASK" == "" -o "$TASK" == "No matches." ]
    then
        NEXTTASK="$NEXTTASK None pending"
        STATENEXTTASK="$GOOD"
        return
    fi
    declare -a TASKFIELDS=($( echo "$TASK" | awk 'NR == 2 {print}'))
    declare -a TASK=($( echo "$TASK" | awk 'NR == 4 {print}' ))
    local i=0
    for CURRFIELD in "${TASKFIELDS[@]}"
    do
        if [ "$CURRFIELD" == "Due" ]
        then
            local DUEDATE="${TASK[$i]:5:5}"
            NEXTTASK="$NEXTTASK ($DUEDATE)"
        fi
        if [ "$CURRFIELD" == "Urg" ]
        then
            local TASKURGENCY="$( printf "%.0f" ${TASK[$i]} )"
            STATENEXTTASK="$GOOD"
            if [ "$TASKURGENCY" -ge "14" ]
            then
                STATENEXTTASK="$BAD"
            elif [ "$TASKURGENCY" -ge "10" ]
            then
                STATENEXTTASK="$MED"
            fi
        fi
        if [ "$CURRFIELD" == "Description" ]
        then
            NEXTTASK="$NEXTTASK ${TASK[@]:$i:40}"
        fi
        let i=$i+1
    done
    NEXTTASK="${NEXTTASK:0:40}"
}

# Main status loop
function status_loop {
    # Initial JSON information stuff for i3bar
    echo '{ "version": 1, "click_events": true }'
    echo '['
    echo '[],'
    
    # Enter main output loop
    while :
    do
        # Next Task
        if [ "$((CYCLES % CYCNEXTTASK))" -eq "0" ]
        then
            set_nexttask
        fi
    
        # Battery level
        if [ "$((CYCLES % CYCBATTERY))" -eq "0" ]
        then
            set_battery
        fi
    
        # Volume level/mute
        if [ "$((CYCLES % CYCVOLUME))" -eq "0" ]
        then
            set_volume
        fi

        # Media playing or not
        if [ "$((CYCLES % CYCMEDIA))" -eq "0" ]
        then
            set_media
        fi
    
        # Check for number of updates
        if [ "$((CYCLES % CYCUPDATES))" -eq "0" ]
        then
            set_updates
        fi
    
        # Check the uptime
        if [ "$((CYCLES % CYCUPTIME))" -eq "0" ]
        then
            set_uptime
        fi
    
        # Disk free
        if [ "$((CYCLES % CYCDISKUSE))" -eq "0" ]
        then
            set_diskuse
        fi
    
        # CPU temp
        if [ "$((CYCLES % CYCCPUTEMP))" -eq "0" ]
        then
            set_cputemp
        fi
    
        # Date and time
        if [ "$((CYCLES % CYCDATETIME))" -eq "0" ]
        then
            DATETIME="$( date +'%a, %d %b %Y - %H:%M' )"
        fi
        # We want to make it more apparent when things go wrong
        # And not have the warning lagging around past the threat
        STATEDATETIME="$GOOD"
        if [ "$STATEBATTERY" -eq "$FATAL" -o "$STATECPUTEMP" -eq "$FATAL" ]
        then
            STATEDATETIME="$FATAL"
        elif [ "$STATEBATTERY" -eq "$BAD" -o "$STATECPUTEMP" -eq "$BAD" ]
        then
            STATEDATETIME="$BAD"
        fi
    
        ## Time to build our output
        COLORENUM=(["$GOOD"]="$COLORGOOD" "$COLORMED" "$COLORBAD" "$COLORFATAL")
        # Emptyfield to get a separator from i3bar
        OUTPUT="[$EMPTYFIELD,"
        # Put on next todo info
        OUTPUT="$OUTPUT$OPEN$NEXTTASK $BIGSPACE$NAMENEXTTASK${COLORENUM[$STATENEXTTASK]}$CLOSE,"
        # Put on date-time info
        OUTPUT="$OUTPUT$OPEN$DATETIME $NAMEDATETIME${COLORENUM[$STATEDATETIME]}$CLOSE,"
        # Put on battery info
        OUTPUT="$OUTPUT$OPEN$BATTERY $BIGSPACE$NAMEBATTERY${COLORENUM[$STATEBATTERY]}$CLOSE,"
        # Put on media info (if it should be printed)
        if [[ "$STATEMEDIA" != "$NOPRINT" ]]
        then
            OUTPUT="$OUTPUT$OPEN$MEDIA $NAMEMEDIA${COLORENUM[$STATEMEDIA]}$CLOSE,"
        fi
        # Put on volume info
        OUTPUT="$OUTPUT$OPEN$VOLUME $BIGSPACE$NAMEVOLUME${COLORENUM[$STATEVOLUME]}$CLOSE,"
        # Put on updates info
        OUTPUT="$OUTPUT$OPEN$UPDATES $NAMEUPDATES${COLORENUM[$STATEUPDATES]}$CLOSE,"
        # Put on uptime info
        OUTPUT="$OUTPUT$OPEN$UPTIME $BIGSPACE$NAMEUPTIME${COLORENUM[$STATEUPTIME]}$CLOSE,"
        # Put on disk use info
        OUTPUT="$OUTPUT$OPEN$DISKUSE $BIGSPACE$NAMEDISKUSE${COLORENUM[$STATEDISKUSE]}$CLOSE,"
        # Put on cpu temp info
        OUTPUT="$OUTPUT$OPEN$CPUTEMP $NAMECPUTEMP${COLORENUM[$STATECPUTEMP]}$CLOSE"
        # Put on the end
        OUTPUT="$OUTPUT],"
    
        # Echo the output to i3bar
        echo "$OUTPUT"
        
        # Toggle the badcolor
        if [ "$FATALCOLOR" -eq "0" ]
        then
            FATALCOLOR=1
            COLORFATAL=$COLORFATAL2
        else
            FATALCOLOR=0
            COLORFATAL=$COLORFATAL1
        fi
    
        # Increment the cycle number, reset back to lower value once appropriately
        let CYCLES=$CYCLES+1
        if [ "$CYCLES" -gt "$RESETCYCLES" ]
        then
            let CYCLES=$CYCLES-$RESETCYCLES
        fi
    
        sleep "$SLEEPTIME";
    done
}

# Main event loop
# Thank h2status for me being able to see how to do this: https://gist.github.com/memeplex/8115385
# That solution is probably way better than this one - I recommend looking at it
function event_loop {
    while read line
    do
        # Get which status was clicked - and with witch button
        EVENT_NAME=$(echo "$line" | grep -Po '"name":".*?"')
        EVENT_NAME=${EVENT_NAME:8:(-1)}
        MOUSE_BUTTON=$(echo "$line" | grep -Po '"button":.')
        MOUSE_BUTTON=${MOUSE_BUTTON:9:1}
        
        # Based on which status was clicked, do different things
        case $EVENT_NAME in
        "nexttask")
            urxvt -T "task 0ebb42" -e bash -c "task next && bash" &
            ;;
        "date")
            urxvt -T "wyrd c35ce2" -geometry 100x30 -e wyrd &
            ;;
        "volume")
            case $MOUSE_BUTTON in
            "1")
                amixer -q set Master 5%-
                ;;
            "2")
                amixer -q set Master toggle
                ;;
            "3")
                amixer -q set Master 5%+
                ;;
            esac
            ;;
        "media")
            case $MOUSE_BUTTON in
            "1")
                echo 'cycle pause' > /tmp/umpv-fifo-*
                ;;
            "2")
                echo 'quit' > /tmp/umpv-fifo-*
                ;;
            "3")
                i3-msg -q "workspace number 9"
                ;;
            esac
            ;;
        esac
    done
}

# Run our main loops (output, and input (for clicks))
status_loop &
event_loop &> /dev/null

