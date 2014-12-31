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
  echo ":: Vous êtes dans le dossier pour modifier le nom des interfaces réseau::"
  cd /etc/sysconfig/network-scripts

	echo ":: Modifiez manuellement les fichiers ::"
fi

exit 0
