gnome-settings-daemon &      # handles themes, starts gnome-screensaver. You may have to use gconf to disable it setting the background.
gnome-power-manager &        # for laptops and stuff
gnome-volume-manager &       # for mounting CDs, USB sticks, and such
eval `gnome-keyring-daemon`  # SSH/GPG agent
#exec /usr/bin/spectrwm
xrdb ~/.Xresources
exec /usr/local/bin/awesome
