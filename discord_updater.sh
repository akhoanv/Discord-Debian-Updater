#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please re-run the script as root, as dpkg and apt will be involved"
  exit
fi

FILE_DIR=$(pwd)

while getopts d: opts; do
   case ${opts} in
      d) FILE_DIR=${OPTARG} ;;
   esac
done

cd ${FILE_DIR}
echo Currently at $(pwd)

echo Fetching latest Deb file
wget "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb

INSTALL_FILE=$(ls -t discord* | head -1)

echo Installing ${INSTALL_FILE}

apt remove discord -y
dpkg -i ${INSTALL_FILE}
rm ${INSTALL_FILE}
