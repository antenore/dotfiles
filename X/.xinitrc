#!/bin/bash
#set -x

# Logging

exec > >(tee ~/logs/xinit.$$.log)
exec 2>&1

export BROWSER=firefox

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f ~/.xprofile ] && source ~/.xprofile

mydisplays=1
[[ $(xrandr | grep -c " connected ") -eq 2 ]] && mydisplays=2
[[ $(xrandr | grep -c " connected ") -eq 1 ]] && mydisplays=1

# Fonts

. /etc/profile.d/infinality-settings.sh
xset +fp /usr/share/fonts/local
xset +fp ~/.fonts
xset fp rehash

# Dbus fix
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

# Gtk themes 
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Dropbox
dropboxd &

#DEFAULT_SESSION=/usr/bin/awesome
DEFAULT_SESSION=/usr/bin/i3
#DEFAULT_SESSION=/usr/bin/spectrwm

case $1 in
    spectrwm)
        exec /usr/bin/spectrwm ;;
    openbox)
        exec openbox-session ;;
    awesome)
        exec awesome ;;
    i3)
        if [[ -f ~/.i3/config.$mydisplays ]] ; then
            exec i3 -c ~/.i3/config.$mydisplays
        else
            #default
            exec i3
        fi
        ;;
    *)
        exec $DEFAULT_SESSION ;;
esac

#export DE=openbox
