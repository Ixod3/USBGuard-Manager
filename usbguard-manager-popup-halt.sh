#!/bin/bash

# Title: USBGuard-Manager-Popup-Halt
# Autor: Ixod3
# Creation date: 2023-06-02
# Description: Bash script udev Halt popup when USB was disconnect

script_popup="/usr/bin/usbguard-manager-popup"

output=$(pgrep -f "$script_popup")
count=$(echo "$output" | wc -l)

if [ "$count" -gt 1 ]; then
    echo "[USGuard-Manager][`date`] USGuard-Manager-Popup close, USB key unplugged" >> /var/log/syslog
    pkill -f "$script_popup"
else
    echo "[USGuard-Manager][`date`] USGuard-Manager-Popup not close because not open" >> /var/log/syslog
fi
