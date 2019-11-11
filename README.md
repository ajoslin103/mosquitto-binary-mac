Author: Allen Joslin
EMail: allen.joslin@gmail.com

Project:

I needed an installer for Mosquitto for the Mac for a project that I was building for a client

My client's staff could not be asked to install and operate Homebrew for the Mac to get Mosquitto - but they can run installers

So this project uses the fabulous FPM (https://github.com/jordansissel/fpm) to make a Mac installer for Mosquitto using the files installed by Homebrew for the Mac on your developer machine

You must have already installed FPM and Homebrew - then you can get into this project folder and run mosquitto-buildPKG.sh

It will check to be sure that Mosquitto is installed and then copy the assets required and build a Mac OS X Installer 

Note: this installer creates an un-install script: /usr/local/bin/uninstall-mosquitto.sh

Enjoy

Al;