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

      # Activer squid et le lancer
      systemctl enable squid
      systemctl start squid
fi

exit 0
