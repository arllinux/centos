#!/bin/bash

# 004_firewall_eth0.sh
# JP Antinoux - janvier 2015

CWD=$(pwd)

if [ $USER != "root" ] ;
    then
	echo "Pour exécuter ce script il faut être l'utilisateur root !"
else

# Si le fichier "firewall.sh" est présent
# Autrement dit : si ce n'est pas la première utilisation
  if [ -f /usr/local/sbin/firewall.sh ] ;
    
    then
      
      # l'ouvrir, le modifier...
        vim /usr/local/sbin/firewall.sh
     	
			# Exécuter le script
				bash -c /usr/local/sbin/firewall.sh

      # Appliquer les modifications
        bash -c /usr/local/sbin/firewall.sh

      # Appliquer les modifications
        systemctl restart iptables.service
    
    else
			#########################################
     	# Si le script n'est pas encore en place#
			#########################################

      # Copier le fichier qui va permettre les réglages du parefeu
      # vers /usr/local/sbin
        cp $CWD/../firewall/firewall.sh /usr/local/sbin/firewall.sh
      
      # l'ouvrir, le modifier...
        vim /usr/local/sbin/firewall.sh

      # Exécuter le script
				bash -c /usr/local/sbin/firewall.sh
      
      # Appliquer les modifications
       bash -c /usr/local/sbin/firewall.sh

      # Rendre persistant le relais des paquets
        cat $CWD/../firewall/sysctl.conf2 >> /etc/sysctl.conf

      # Mettre en place l'encapsuleur TCP
        vim $CWD/../firewall/hosts.allow
        cat $CWD/../firewall/hosts.allow > /etc/hosts.allow
        cat $CWD/../firewall/hosts.deny > /etc/hosts.deny

      # Lancer le service
        systemctl restart iptables.service
      
      # Le rendre persistant pour le prochain démarrage
        systemctl enable iptables.service
 fi      
      echo -e "------------------------------------"
      echo -e ":: Tester si le service est actif ::"
      echo -e "------------------------------------"
        systemctl status iptables.service

      echo -e "------------------------------------"
      echo -e ":: Patientez 5 secondes : ....... ::"
      echo -e "------------------------------------"
        sleep 5
      
      echo -e "-----------------------------------"
      echo -e ":: Voir ce qu'en pense le kernel ::"
      echo -e "-----------------------------------"
        tail -f /var/log/messages | grep firewall

fi

exit 0
