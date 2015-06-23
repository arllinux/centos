#!/bin/bash
#

# 006_mail_raid.sh
# JP Antinoux - janvier 2015

CWD=$(pwd)

if [ $USER != "root" ] ;
    then
	echo "Pour exécuter ce script il faut être l'utilisateur root !"
else

	echo ":: le fichier de configuration du raid va s'ouvrir pour
  permettre les modifications"
  bash -c chrono.sh
  # Mise en place de l'adresse mail pour les erreurs raid
    vim /etc/mdadm.conf

fi

exit 0
