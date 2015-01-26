#!/bin/bash

/usr/bin/xhost + local:
sudo -H -u harden /bin/claws-mail &
#sudo -H -u harden /usr/bin/thunderbird &
#sudo -H -u harden /usr/bin/chromium-browser &
sudo -H -u harden /bin/firefox &
sleep 1 && exit 0
