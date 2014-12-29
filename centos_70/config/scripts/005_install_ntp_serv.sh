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
	yum -y install ntp ntpdate

  echo ":: Arrêt du service ntp ::"
  systemctl stop ntpd.service
  
  echo ":: Mise à jour initiale de l'horloge ::"
  ntpdate fr.pool.ntp.org
 
  echo ":: Ajustement du fichier de configuration ::"
	touch /var/log/ntp.log
	chown ntp:ntp /var/log/ntp.log
	cp /etc/ntp.conf /etc/ntp.conf_old
	cat $CWD/../ntp/etc/ntp.conf > /etc/ntp.conf

  echo ":: activation et lancement du service ::"
  systemctl enable ntpd.service
  systemctl start ntpd.service
	
fi

exit 0

