#!/bin/bash

# 001_base.sh
# JP Antinoux - décembre 2014

CWD=$(pwd)
COUNT="0"

if [ $USER != "root" ] ;
    then
	echo "Pour exécuter ce script il faut être l'utilisateur root !"
else

    # test du system avec systemd
	echo "Test des disques" > liste_boot
	COUNT=$(systemctl status /dev/sd* | grep active | wc -l)
	for COUNT in $COUNT; do
	systemctl status /dev/sd* | grep dev-sd* >> liste_boot
	systemctl status /dev/sd* | grep active >> liste_boot
	done
	COUNT=$(systemctl status /dev/md* | grep active | wc -l)
	for COUNT in $COUNT; do
	systemctl status /dev/md* | grep dev-md* >> liste_boot
	systemctl status /dev/md* | grep active >> liste_boot
	done
	
fi

exit 0
