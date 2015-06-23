#!/bin/bash

# 010_squid.sh
# JP Antinoux - mars 2015

CWD=$(pwd)

if [ $USER != "root" ] ;
    then
	echo "Pour exécuter ce script il faut être l'utilisateur root !"
else

      # Installer squid
      yum -y install squid

      # Mettre en place la configuration
      cat $CWD/../squid/squid > /etc/squid/squid.conf
  
    	# Ouverture des ports du parefeu
      # Ouvre le fichier firewall pour permettre les modifications      
			echo ":: le fichier de configuration du parefeu va s'ouvrir pour
  		permettre les modifications"
  		bash -c chrono.sh
      vim /usr/local/sbin/firewall.sh
        
	    # Exécuter le script
		 	bash -c /usr/local/sbin/firewall.sh

      # Relance le service pour mettre à jour et figer les règles      
      systemctl restart iptables.service

      # Activer squid et le lancer
      systemctl enable squid
      systemctl start squid
fi

exit 0
