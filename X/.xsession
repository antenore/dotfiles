AWT_TOOLKIT=XToolkit ; export AWT_TOOLKIT
JAVA_AWT_WM_NONREPARENTING=1; export _JAVA_AWT_WM_NONREPARENTING
_JAVA_OPTIONS="-Djava.net.preferIPv4Stack=true -Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel" ; export _JAVA_OPTIONS
IRONIC_WM_NAME="LG3D" ; export IRONIC_WM_NAME

gnome-settings-daemon &      # handles themes, starts gnome-screensaver. You may have to use gconf to disable it setting the background.
gnome-power-manager &        # for laptops and stuff
gnome-volume-manager &       # for mounting CDs, USB sticks, and such
eval `gnome-keyring-daemon`  # SSH/GPG agent
#exec /usr/bin/spectrwm
exec .screenlayout/dual-external.sh
xrdb ~/.Xresources
urxvt256cd -q -o -f
#xcompmgr -cCfF -t-5 -l-5 -r4.2 -o.55 -D2 &
#exec /usr/local/bin/awesome
