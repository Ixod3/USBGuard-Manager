# USBGuard-Manager

This pyqt app is a GUI for usbguard tool. The objective is to democratize the control of USB keys on linux machines.

The default comment of each device is "Default", it's recommand to change it to identify each device.

## Soon

- "Insuffisante right" banner
- Date of last connexion for each device

## Install

Prerequis :

```sh
sudo apt install usbguard python3-pip
```

Install :

```sh
git clone git@github.com:Ixod3/USBGuard-Manager.git
cd USBGuard-Manager
sudo ./setup.sh
```

Remove setup folder :

```sh
rm -rf ../USBGuard-Manager
```