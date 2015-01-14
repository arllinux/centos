#!/bin/bash

# 004_firewall_eth0.sh
# JP Antinoux - janvier 2014

CWD=$(pwd)

[ $USER != "root" ] ;
if [ $? = "0" ]
    then
	echo "Pour exécuter ce script il faut être l'utilisateur root !"
else

# Si le fichier "firewall.sh" est présent
  if [ -f /usr/local/sbin/firewall.sh ] ;
    
    then
      
      # l'ouvrir, le modifier...
        vim /usr/local/sbin/firewall.sh
      
      # Appliquer les modifications
        systemclt restart firewall.service
    
    else
      
      # Copier le fichier qui active le service que j'ai créé
      # vers l'emplacement adhéquat.
        cp $CWD ../firewall/firewall.service /usr/lib/systemd/system/
      
      # Copier le fichier qui va permettre les réglages du parefeu
      # vers /usr/local/sbin
        cp $CWD/firewall.sh /usr/local/sbin/firewall.sh
      
      # l'ouvrir, le modifier...
        vim /usr/local/sbin/firewall.sh
      
      # Lancer le service
        systemctl start firewall.service
      
      # Le rendre persistant pour le prochain démarrage
        systemctl enable firewall.service
      
      echo -e "------------------------------------"
      echo -e ":: Tester si le service est actif ::"
      echo -e "------------------------------------"
      systemctl status firewall.service
      
      echo -e "-----------------------------------"
      echo -e ":: Voir ce qu'en pense le kernel ::"
      echo -e "-----------------------------------"
      cat /var/log/messages | grep Firewall

  fi
fi

exit 0
