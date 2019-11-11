#!/bin/bash

rpmName="mosquitto"

# check to see if homebrew is installed
/usr/local/bin/brew --version && brewResult=$?
if [ ${brewResult} .eq 0 ] ; then

    # stop mosquitto if installed
    /usr/local/bin/brew services stop mosquitto

    # remove mosquitto if installed
    /usr/local/bin/brew remove mosquitto
fi

# finished
