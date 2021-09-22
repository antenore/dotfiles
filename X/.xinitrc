#!/bin/bash
# This is a sample .xinitrc file (to be executed with xinit or startx)

#if [ -d /etc/X11/xinit/xinitrc.d ]; then
    #for f in /etc/X11/xinit/xinitrc.d/*; do
        #[ -x "$f" ] && ; "$f"
    #done
    #unset f
#fi

#export GTK_IM_MODULE=ibus
#export QT_IM_MODULE=xim
#export XMODIFIERS=@im=ibus
#/usr/local/bin/mozc start
#ibus-daemon -r --daemonize --xim


# font bullshit
xset +fp $HOME/.fonts
xset fp rehash

# source the Xresources for the terminal
xrdb -merge ~/.Xresources &

#color profiles
#xcalib -d :0 ~/.color/icc/271S4.icm

# Ctrl-Alt-Backspace kills the X session
setxkbmap -option terminate:ctrl_alt_bksp

# sets your keyboard to 'us' keymap
#setxkbmap us &

# caps lock to backspace
#setxkbmap -option caps:backspace

# Set compose key to menu
setxkbmap -option compose:menu

# read Xmodmap file - please edit it first
#xmodmap ~/.Xmodmap &

# helpful to have keycombos set - see also ~/.xbindkeysrc (catwm has its own!)
#xbindkeys -f ~/.xbindkeysrc &

## DPMS monitor setting (standby suspend off)(seconds)
#xset dpms 300 600 900 &

## for who the bell tolls (percent;pitch;duration)
## test with xset q | grep bell
#xset b 100 400 100

# make the cursor point in the 'right' direction
#xsetroot -cursor_name left_ptr &

# set a wallpaper
#hsetroot -tile /foo/bar/image.png &
#eval $(cat ~/.fehbg)

# candy - pick one or none
#xcompmgr -cCfF -t-5 -l-5 -r4.2 -o.55 -D2 &
#compton -bcCGf --shadow-red 0.2 --shadow-green 0.3 --shadow-blue 0.2

# Stuff I need running
#eval `gnome-keyring-daemon`  # SSH/GPG agent
xscreensaver &
#nm-applet &
#savtray &

AWT_TOOLKIT=XToolkit
export AWT_TOOLKIT
#AWT_TOOLKIT=MToolkit ; export AWT_TOOLKIT
#_JAVA_AWT_WM_NONREPARENTING=1; export _JAVA_AWT_WM_NONREPARENTING
#_JAVA_OPTIONS="-Djava.net.preferIPv4Stack=true -Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel" ; export _JAVA_OPTIONS
_JAVA_OPTIONS="-Djava.net.preferIPv4Stack=true" ; export _JAVA_OPTIONS
#IRONIC_WM_NAME="LG3D" ; export IRONIC_WM_NAME

#wmname LG3D

#DEFAULTSESSION=i3

#case "$1" in
    #openbox) exec openbox-session ;;
    #xfce) exec xfce4-session ;;
    #gnome3) exec gnome-session ;;
    #lxde) exec lxsession ;;
    #i3) exec i3;;
    #dwm) exec /usr/local/bin/dwm;;
    #mate) exec mate-session;;
    #spectrwm) exec spectrwm;;
    #*) exec $DEFAULTSESSION ;;
#esac
