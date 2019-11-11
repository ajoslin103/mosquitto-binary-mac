#!/bin/bash

echo -e "\t "
echo -e "\t this script will remove the mosquitto binary and"
echo -e "\t optionally, the dependencies installed with it"

if [[ $(whoami) != "root" ]] ; then
    echo -e "\t "
    echo -e "\t error: you must run this script as root"
    echo -e "\t ex:   sudo $0"
    echo -e "\t "
    exit 1
fi

user=$(stat -f%Su /dev/console)

echo -e "\t "
echo -e "\t stop the service"
sudo -u ${user} /bin/launchctl unload /usr/local/opt/mosquitto-1.6.7/homebrew.mxcl.mosquitto.plist

echo -e "\t removing the working folder"
/bin/rm -rf /usr/local/var/mosquitto

echo -e "\t removing the prefs folder"
/bin/rm -rf /usr/local/etc/mosquitto

echo -e "\t removing the mosquitto binaries symlinks"
/bin/rm -f /usr/local/bin/mosquitto_passwd
/bin/rm -f /usr/local/bin/mosquitto_pub
/bin/rm -f /usr/local/bin/mosquitto_rr
/bin/rm -f /usr/local/bin/mosquitto_sub

echo -e "\t removing the mostquitto binary and the symlink"
/bin/rm -f /usr/local/opt/mosquitto
/bin/rm -rf /usr/local/opt/mosquitto-1.6.7

echo -e "\t "
echo -e "\t mosquitto is un-installed"

echo -e "\t "
echo -e "\t note: there were extra libraries installed that mosquitto needed"
echo -e "\t       (libevent, libwebsockets, libuv, and openssl@1.1)"
echo -e "\t       and while it's unlikely that you need these,"
echo -e "\t       you can hit ctrl-c to save them"
echo -e "\t       or hit return to delete them"
echo -e "\t "

read pause

echo -e "\t removing symlinks to the other binaries we installed"
/bin/rm -f /usr/local/opt/libevent
/bin/rm -f /usr/local/opt/openssl@1.1
/bin/rm -f /usr/local/opt/libwebsockets
/bin/rm -f /usr/local/opt/libuv

echo -e "\t removing the other binaries we installed"
/bin/rm -rf /usr/local/opt/libevent-2.1.11_1
/bin/rm -rf /usr/local/opt/libuv-1.31.0
/bin/rm -rf /usr/local/opt/libwebsockets-3.2.0_1
/bin/rm -rf /usr/local/opt/openssl@1.1-1.1.1d

echo -e "\t "
echo -e "\t mosquitto and all it's dependencies have been removed"
echo -e "\t "

# finished
