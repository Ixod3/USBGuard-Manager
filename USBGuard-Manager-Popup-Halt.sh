#!/bin/bash

script_popup="USBGuard-Manager-Popup"

output=$(pgrep -f "$script_popup")
count=$(echo "$output" | wc -l)

if [ "$count" -gt 1 ]; then
    echo "[USGuard-Manager][`date`] USGuard-Manager-Popup close, USB key unplugged" >> /var/log/syslog
    pkill -f "$script_popup"
else
    echo "[USGuard-Manager][`date`] USGuard-Manager-Popup not close because not open" >> /var/log/syslog
fi
