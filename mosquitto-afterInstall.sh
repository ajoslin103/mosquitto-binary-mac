#!/bin/bash

rpmName="mosquitto"

user=$(stat -f%Su /dev/console)

# create a working folder
/bin/mkdir -p /usr/local/var/mosquitto

# symlink mosquitto binaries into /usr/local/bin
/bin/ln -s /usr/local/opt/mosquitto/bin/mosquitto_passwd /usr/local/bin/mosquitto_passwd
/bin/ln -s /usr/local/opt/mosquitto/bin/mosquitto_pub /usr/local/bin/mosquitto_pub
/bin/ln -s /usr/local/opt/mosquitto/bin/mosquitto_rr /usr/local/bin/mosquitto_rr
/bin/ln -s /usr/local/opt/mosquitto/bin/mosquitto_sub /usr/local/bin/mosquitto_sub

# ensure the Mosquitto service 
sudo -u ${user} /bin/launchctl unload /usr/local/opt/mosquitto-1.6.7/homebrew.mxcl.mosquitto.plist
sudo -u ${user} /bin/launchctl load /usr/local/opt/mosquitto-1.6.7/homebrew.mxcl.mosquitto.plist

# finished
