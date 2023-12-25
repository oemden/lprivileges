#!/bin/bash
# Linux Privileges - uninstall
# ------------------------------------------------------------
Version_main=1.3
version_script=0.3
# ------------------------------------------------------------

if [[ "$EUID" -ne 0 ]] ; then
 echo "must be run as root"
 exit 1
fi

echo " Unloading Daemons"
systemctl stop --now lprivileges.*
systemctl disable --now lprivileges.path
systemctl disable --now lprivileges.service

echo " Deleting lprivileges daemons"
rm -Rf /etc/systemd/system/lprivileges*

echo " Deleting lprivileges logs"
rm -Rf /var/log/lprivileges

echo " Deleting lprivileges conf"
rm -Rf /usr/local/etc/lprivileges*

echo " Deleting lprivileges watch folder"
rm -Rf /var/tmp/lprivileges

echo " Deleting lprivileges scripts"
rm -Rf /usr/local/bin/lprivileges*

echo " Deleting lprivileges gnome applications"
rm -Rf /usr/share/applications/linux-privileges.desktop

echo " Deleting lprivileges icons"
rm -Rf /usr/local/share/icons/lprivileges

echo " Deleting lprivileges icons"
# Warning -> we should create an uninstall script at the installation or fix the Corporate icon.
# for now no corporate icon is used as it create too many notifications.
rm -Rf /usr/local/share/icons/corp

echo "uninstalled Privileges"

exit 0
