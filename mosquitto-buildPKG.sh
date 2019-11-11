#!/bin/bash

pkgName="mosquitto"

# these are the packages/versions we are going install -- you should check this for accuracy
sourcePackages="libevent/2.1.11_1 libuv/1.31.0 libwebsockets/3.2.0_1 openssl@1.1/1.1.1d mosquitto/1.6.7"

# remember where we started
originalWd=$(pwd)

# check to see if homebrew is installed
/usr/local/bin/brew --version && brewResult=$?
if [ ${brewResult} -ne 0 ] ; then
    # cannot continue 
    echo "Error: the `brew` cmd is not available, cannot continue."
    exit $brewResult
fi

# insure that brew is installed and up-to-date
/usr/local/bin/brew install mosquitto && brewResult=$?
if [ ${brewResult} -ne 0 ] ; then
    # cannot continue 
    echo "Error: the `brew install mosquitto` cmd did not succeed, please fix whatever the error is and try again."
    exit $brewResult
fi

# insure that mosquitto is started
/usr/local/bin/brew services start mosquitto && brewResult=$?
if [ ${brewResult} -ne 0 ] ; then
    # cannot continue 
    echo "Error: the `brew services start mosquitto` cmd did not succeed, please fix whatever the error is and try again."
    exit $brewResult
fi

# create a location to assemble the binary 
cd ${originalWd} && /bin/rm -rf ./mosquitto && mkdir -p ./mosquitto && buildDir="./mosquitto"
brewResult=$?
if [ ! -d "${buildDir}" ] ; then
    # cannot continue 
    echo "Error: could not create a build folder at: ${buildDir}, please fix whatever the error is and try again."
    exit $brewResult
fi

packageDir="/usr/local/opt"
# copy and link the supporting packages into our working location
# the afterInstall package will create the final linkages into the PATH
echo "copy and link the supporting packages into our working location"
cd ${originalWd} && /bin/mkdir -p ${buildDir}/${packageDir} && cd ${buildDir}/${packageDir} &&
for eachPackage in $(echo "${sourcePackages}") ; do
    destPackage="$(echo ${eachPackage} | sed 's|/.*||g')"
    destPackageDir="$(echo ${eachPackage} | sed 's|/|-|g')"
    /bin/cp -pr "/usr/local/Cellar/${eachPackage}" "${destPackageDir}"
    /bin/ln -s "${destPackageDir}/" "./${destPackage}"
done && 
cd ${originalWd} 
brewResult=$?
if [ ! -d "${buildDir}" ] ; then
    # cannot continue 
    echo "Error: could not copy and link the supporting packages into our working at: ${buildDir}, please fix whatever the error is and try again."
    exit $brewResult
fi

# thisFolder=/goes/there andThisOne=/goes/here
pkgDirs=$(cat <<EOF
./mosquitto/usr/local/opt=/usr/local/
./mosquitto/usr/local/opt/mosquitto/etc/mosquitto=/usr/local/etc/
EOF
)

# there may be single files
pkgFiles=$(cat <<EOF
uninstall-mosquitto.sh=/usr/local/bin/uninstall-mosquitto.sh
start-mosquitto.sh=/usr/local/bin/start-mosquitto.sh
EOF
)

# remove the previous build
mkdir -p pkgs
rm -f pkgs/*.pkg

# build the pkg
fpm -t osxpkg -p pkgs/ -n ${pkgName} -v 1.6.7 --after-install mosquitto-afterInstall.sh --before-install mosquitto-beforeInstall.sh -s dir ${pkgDirs} ${pkgFiles} 

# finished
