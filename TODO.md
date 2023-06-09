# USBGUARD-GTK
interface graphique USBGUARD

## Install dependancy

```
sudo pip3 install qdarkstyle
```

## Manager

+ Trouver une icone pour l'appli (icone USBGUARD ?)
- Refaire le setup.sh
~ Refresh la liste des peripheriques bloqué toutes les 5 secondes
+ Ajout du script python en /usr/bin/usbguard-Manager
- Ajout extension.debian.org ?
+ ajouter le theme dark et light dans setup.sh
+ Faire une entete en haut du code
+ Centrer le usbguard-manager par rapport a la taille de l'ecran
+ Créer un group nommé "usbguard"
+ Définir le groupe "usbguard" dans le fichier /etc/usbguard/usbguard-daemon.conf

## Git
usbguard-manager.conf
usbguard-manage-popup-halt.sh
usbguard-manage-popup-launch.sh
usbguard-manage
usbguard-manage-popup
setup.sh
80-usbguard-manager.rules

## Arborescence
/etc/usbguard/themes
/etc/usbguard/usbguard-manager.conf
/etc/usbguard/usbguard-manage-popup-halt.sh
/etc/usbguard/usbguard-manage-popup-launch.sh
/usr/bin/usbguard-manage
/usr/bin/usbguard-manage-popup
/etc/udev/rules.d/80-usbguard-manager.rules




## Debug

```sh
sudo tail -f /var/log/syslog | grep "USGuard-Manager"
```

## Pop-up

+ Configurer le theme gnome
- Récupération des dimensions de l'écran dans /etc/usbguard/usbguard-manager.conf
- Message de refus a cause des droits non suffisants (avec le code de retour ?)
+ Préparer le setup.sh avec les PATHs d'installation
+ Centrer le usbguard-manager-popup par rapport a la taille de l'ecran
+ Identification de $DISPLAY et $XAUTHORITY dans le setup.sh pour le placer dans USBGuard-Manager-Popup-Launch.sh
+ Définir un répertoire d'icones dans /etc/usbguard/icones et changer les path dans le script python
+ Ecrire une arborescence de l'application

/etc/udev/rules.d/80-usbguard-manager.rules
```sh
ACTION=="add", SUBSYSTEMS=="usb", RUN+="/bin/systemd-run --scope /home/ixod3/Téléchargements/USBGuard-Manager/USBGuard-Manager-Popup-Launch.sh"
ACTION=="remove", SUBSYSTEMS=="usb", RUN+="/home/ixod3/Téléchargements/USBGuard-Manager/USBGuard-Manager-Popup-Halt.sh"
```

Redemarrer le service udev
```sh
sudo systemctl restart udev
```

USBGuard-Manager-Popup-Launch.sh
```sh
#!/bin/bash
vendor_id=$ID_VENDOR_ID
product_id=$ID_MODEL_ID
serial_number=$ID_SERIAL_SHORT

temporary_device=$(sudo usbguard list-devices | grep "allow" |tr -d '\n')

if [[ "$temporary_device" =~ "$vendor_id:$product_id" ]]; then

    echo "[USGuard-Manager][`date`] USGuard-Manager-Popup don't launch, device ID not recognize, probably in mounting" >> /var/log/syslog

elif grep -q "$vendor_id:$product_id" /etc/usbguard/rules.conf; then

    echo "[USGuard-Manager][`date`] USGuard-Manager-Popup don't launch, device $vendor_id:$product_id already accept" >> /var/log/syslog

elif [[ "$temporary_device" =~ "$vendor_id:$product_id" ]]; then

    echo "[USGuard-Manager][`date`] USGuard-Manager-Popup don't launch, device $vendor_id:$product_id already accept temporary" >> /var/log/syslog

else

    echo "[USGuard-Manager][`date`] USGuard-Manager-Popup launch, device $vendor_id:$product_id block and wait" >> /var/log/syslog
    export DISPLAY=':1'
    export XAUTHORITY='/run/user/1000/gdm/Xauthority'
    nohup /usr/bin/python3 /home/ixod3/Téléchargements/USBGuard-Manager/USBGuard-Manager-Popup $vendor_id:$product_id $serial_number> /dev/null 2>&1 &

fi
```

USBGuard-Manager-Popup-Launch.sh
```sh
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

```