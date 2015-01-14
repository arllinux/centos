#!/bin/bash

# ./005_install_ntp_serv.sh

# Dernière modifs 20/08/2012 - 10/09/2012 - 25/09/2012 - 21/03/2013
# JP antinoux - décembre 2014
CWD=$(pwd)

[ $USER != "root" ]
if [ $? = "0" ]
    then
	echo "Pour exécuter ce script il faut être l'utilisateur root !"
else

	# NTP
  echo ":: Ouvrir le port du parefeu : 123 ::"
  sleep 3
  vim /usr/local/sbin/firewall.sh
  systemctl restart firewall.service

  echo "--------------------------"
  echo ":: Arrêt du service ntp ::"
  echo "--------------------------"
  systemctl stop ntpd.service
  
  echo ":: Mise à jour initiale de l'horloge ::"
  ntpdate fr.pool.ntp.org
 
  echo "--------------------------------------------"
  echo ":: Ajustement du fichier de configuration ::"
  echo "--------------------------------------------"
	touch /var/log/ntp.log
	chown ntp:ntp /var/log/ntp.log
	cp /etc/ntp.conf /etc/ntp.conf_old
	cat $CWD/../ntp/etc/ntp.conf > /etc/ntp.conf

  echo ":: activation et lancement du service ::"
  systemctl enable ntpd.service
  systemctl start ntpd.service
	
  echo "-----------------------------------------------"
  echo ":: Vérification des serveurs : taper ntpq -p ::"
  echo "-----------------------------------------------"


fi

exit 0

