#!/bin/bash

# Title: USBGuard-Manager-Popup-Launch
# Autor: Ixod3
# Creation date: 2023-06-02
# Description: Bash script udev launch popup when USB was connect

vendor_id=$ID_VENDOR_ID
product_id=$ID_MODEL_ID
serial_number=$ID_SERIAL_SHORT

temporary_device=$(sudo usbguard list-devices | grep "allow" |tr -d '\n')

if [[ "$temporary_device" =~ "$vendor_id:$product_id" ]]; then

    echo "[USGuard-Manager][`date`] USGuard-Manager-Popup don't launch, device ID not recognize" >> /var/log/syslog

elif grep -q "$vendor_id:$product_id" /etc/usbguard/rules.conf; then

    echo "[USGuard-Manager][`date`] USGuard-Manager-Popup don't launch, device $vendor_id:$product_id already accept" >> /var/log/syslog

elif [[ "$temporary_device" =~ "$vendor_id:$product_id" ]]; then

    echo "[USGuard-Manager][`date`] USGuard-Manager-Popup don't launch, device $vendor_id:$product_id already accept temporary" >> /var/log/syslog

else

    echo "[USGuard-Manager][`date`] USGuard-Manager-Popup launch, device $vendor_id:$product_id block and wait" >> /var/log/syslog
    
    who=`who`
    length=${#who}
    position=$((length - 3))
    result=${who:position:2}
    user=$(echo "$who" | cut -d ' ' -f 1)

    export DISPLAY=:1
    export XAUTHORITY='/run/user/1000/gdm/Xauthority'

    nohup /usr/bin/python3 /usr/bin/usbguard-manager-popup $vendor_id:$product_id $serial_number $user> /dev/null 2>&1 &

fi