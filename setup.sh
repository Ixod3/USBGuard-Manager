#/usr/bin/bash

if [ "$(id -u)" != "0" ]; then
    echo "Use root right to launch this script"
    exit 1
else
    # Installation de la base du theme
    /usr/bin/pip3 install qdarkstyle

    # Deplacer les fichiers de conf
    cp ./usbguard-manager.ini /etc/usbguard/usbguard-manager.ini
    cp ./usbguard-manager-popup-halt.sh /etc/usbguard/usbguard-manager-popup-halt.sh
    cp ./usbguard-manager-popup-launch.sh /etc/usbguard/usbguard-manager-popup-launch.sh
    cp ./usbguard-manager /usr/bin/usbguard-manager
    cp ./usbguard-manager-popup /usr/bin/usbguard-manager-popup
    cp 80-usbguard-manager.rules /etc/udev/rules.d/80-usbguard-manager.rules

    # Deplacer les themes
    if [ ! -d /etc/usbguard/themes ];then
        mkdir /etc/usbguard/themes
    fi

    # Verifier si le dossier existe
    cp -r ./themes/* /etc/usbguard/themes/

    # Gestion des droits
    chmod +x /etc/usbguard/usbguard-manager-popup-halt.sh
    chmod +x /etc/usbguard/usbguard-manager-popup-launch.sh
    chmod +x /usr/bin/usbguard-manager
    chmod +x /usr/bin/usbguard-manager-popup

    # Restart udev service
    systemctl restart udev

    # Ecrire les dimensions de l'ecran dans /etc/usbguard/usbguard-manager.conf
    resolution=$(xrandr | awk '/ connected primary/ {split($4, res, "+"); print res[1]}')
    width=$(echo "$resolution" | awk -F'x' '{print $1}')
    height=$(echo "$resolution" | awk -F'x' '{print $2}')
    sed -i "s/\(height=\).*/\1$height/" /etc/usbguard/usbguard-manager.ini
    sed -i "s/\(width=\).*/\1$width/" /etc/usbguard/usbguard-manager.ini

    exit 0
fi
