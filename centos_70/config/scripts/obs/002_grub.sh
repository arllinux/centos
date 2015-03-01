#!/bin/bash
#
# 002_grub.sh
# Jean-Pierre Antinoux - janvier 2015

CWD=$(pwd)

[ $USER != "root" ] ;
if [ $? = "0" ]
    then
	echo "Pour exécuter ce script il faut être l'utilisateur root !"
else

# Intègre à l'emplacement voulu la mention "net.ifnames=0 biosdevname=0 grub"
# qui rétabli les noms d'interfaces réseau sous forme ethx

  cp /etc/default/grub /etc/default/grub_old
  cat /etc/default/grub > $CWD/../grub/grub2
  sed '6 s/\(.\{240\}\)/& net.ifnames=0 biosdevname=0 grub/' $CWD/../grub/grub2 > $CWD/../grub/grub
  cat $CWD/../grub/grub > /etc/default/grub 

# Met à jour grub pour prendre en compte la nouvelle option
  grub2-mkconfig -o /boot/grub2/grub.cfg 

fi

exit 0
