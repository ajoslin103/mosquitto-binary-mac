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

# copy our LaunchAgent Script
/bin/cp -v /usr/local/opt/mosquitto/homebrew.mxcl.mosquitto.plist ~/Library/LaunchAgents/homebrew.mxcl.mosquitto.plist

# start the Mosquitto service
sudo -u ${user} /bin/launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mosquitto.plist

# copy our LaunchAgent Script
/bin/cp -v /usr/local/bin/start-mosquitto.sh ~/Desktop/StartMosquitto.sh
chown ${user}: ~/Desktop/StartMosquitto.sh

touch ~/Desktop/${user}.txt

# finished
