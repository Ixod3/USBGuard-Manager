#/usr/bin/bash

if [ "$(id -u)" != "0" ]; then

    echo "Use root right to launch this script"
    exit 1
    
else

    # SUppresion des fichier de conf
    rm /etc/usbguard/usbguard-manager.ini
    rm ./usbguard-manager-popup-halt.sh /etc/usbguard/usbguard-manager-popup-halt.sh
    rm ./usbguard-manager-popup-launch.sh /etc/usbguard/usbguard-manager-popup-launch.sh
    rm ./usbguard-manager /usr/bin/usbguard-manager
    rm ./usbguard-manager-popup /usr/bin/usbguard-manager-popup
    rm 80-usbguard-manager.rules /etc/udev/rules.d/80-usbguard-manager.rules

    # Supprimer les themes
    if [ -d /etc/usbguard/themes ];then
        rm -rf /etc/usbguard/themes
    fi

    # Restart udev service
    systemctl restart udev

    echo "Done !"

    exit 0
fi