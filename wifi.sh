#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo Run as root.
    exit 1
fi

export SSID=$1
export PSK=$2

if [ -z $SSID ]; then
    echo Need SSID
    exit
fi

if [ -z $PSK ]; then
    echo Need PSK 
    exit
fi

while true; do
    read -p "Are you sure SSID=$SSID and PSK=$PSK is correct? Failure may cause headaches." yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

result=$(./cat_var_re ./templates/interfaces)
sudo echo "$result" > /etc/network/interfaces
