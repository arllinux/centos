#!/bin/bash

# install_grub.sh
# JP Antinoux - Décembre 2014

CWD=$(pwd)

[ $USER != "root" ]
if [ $? = "0" ]
    then
	echo "Pour exécuter ce script il faut être l'utilisateur root !"
else

	# Configuration de grub
  echo ":: Retour aux appelation eth0, 1 et désactivation de l'IPV6 ::"
  cat $CWD/../grub/grub > /etc/default/grub
  echo ":: Mise à jour de grub ::"
  grub2-mkconfig -o /boot/grub2/grub.cfg
  echo ":: Désactivation de l'ipv6 ::"
  systemctl stop ip6tables.service
  systemctl disable ip6tables.service
  
  echo "--------------------------------------------------------"
  echo ":: Il faut se déplacer manuellement dans le répertoire\
  /etc/sysconfig/network-scripts ::"
  echo "--------------------------------------------------------"
  echo "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"

  echo "--------------------------------------------------------"
	echo ":: Ouvrir le ou les fichiers enpS--- ::"
  echo "--------------------------------------------------------"

fi

exit 0
