# USBGuard-Manager

## Not maintained

This pyqt app is a GUI for usbguard tool. The objective is to democratize the control of USB keys on linux machines.

The default comment of each device is "Default", it's recommand to change it to identify each device.

## Soon

- "Insuffisante right" banner
- Date of last connexion for each device
- Rewrite log send to /var/log/syslog by udev script

## Install

Prerequis :

```sh
sudo apt install usbguard python3-pip python3-pyqt5
```

Install :

```sh
git clone https://github.com/Ixod3/USBGuard-Manager.git
cd USBGuard-Manager
sudo ./setup.sh
```

Remove setup folder :

```sh
rm -rf ../USBGuard-Manager
```

## Uninstall

```sh
sudo /etc/usbguard/uninstall-manager.sh
```

## Change Dark to light theme

- Change "theme" value in /etc/usbguard/usbguard-manager.ini (dark or light)
