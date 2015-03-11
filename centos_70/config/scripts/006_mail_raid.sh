#!/bin/bash
#

# 006_mail_raid.sh
# JP Antinoux - janvier 2015

CWD=$(pwd)

if [ $USER != "root" ] ;
    then
	echo "Pour exécuter ce script il faut être l'utilisateur root !"
else

  # Mise en place de l'adresse mail pour les erreurs raid
    vim /etc/mdadm.conf

fi

exit 0
