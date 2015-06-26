#!/bin/bash

# 008_install_samba.sh
#
# JP Antinoux - Janvier 2015 - juin 2015

#'''''''''''''''''''''''''''''''''''''''''''''''''''#
# Modifier les paramètres avant de lancer le script #
#'''''''''''''''''''''''''''''''''''''''''''''''''''#

CWD=$(pwd)

if [ $USER != "root" ]
    then
	echo "Pour exécuter ce script il faut être l'utilisateur root !"
    else
      yum -y install samba samba-client

  echo "-------------------------------------------------------------"
  echo ":: Création de l'utilistateur public pour le serveur samba ::"
  echo "-------------------------------------------------------------"
      useradd -c "Utilisateur public Samba" -g users -s /bin/false smbguest
      passwd -l smbguest 
      smbpasswd -a smbguest -d

  # Choix du nombre de répertoire que l'on veut créer
	# Si vous désirez d'autres nom de répertoire, il faut les modifier avant de
	# lancer le script
  read -p "Pour créer un seul répertoire taper 1 sinon taper 2 :" numrep
  if [ $numrep = 1 ]
    then
      mkdir -pv -m 1777 /srv/samba/public
			mkdir -pv -m 1777 /srv/samba/public/.Corbeille
    else
      mkdir -pv -m 1777 /srv/samba/{public,confidentiel}
			mkdir -pv -m 1777 /srv/samba/public/.Corbeille
			mkdir -pv -m 1777 /srv/samba/confidentiel/.Corbeille
  fi

  echo "-------------------------------------------------"
  echo ":: Mise en place des fichiers de configuration ::"
  echo "-------------------------------------------------"
      cp /etc/samba/smb.conf /etc/samba/smb.conf_old
      cat $CWD/ ../samba/etc/samba/smb.conf.template > /etc/samba/smb.conf
      chmod 644 /etc/samba/smb.conf
			
			# Mise en place d'une corbeille interne aux dossiers créés pour avoir un
			# droit à l'erreur. Celle-ci est gérée par ce script pour suppression des
			# fichiers agés de 2 mois.
      cat $CWD/../samba/etc/cron.weekly/samba_trash.sh.template > /etc/cron.weekly/samba_trash.sh
      chmod 0755 /etc/cron.weekly/samba_trash.sh
      echo "------------------------------------------------"
			echo ":: --> le script de gestion de la corbeille va"
      echo ":: --> s'ouvrir pour visualiser sa mise en place"
      echo "------------------------------------------------"
  		$CWD/pause_script.sh
      vim /etc/cron.weekly/samba_trash.sh

      echo "----------------------------------------------"
    	echo ":: --> le fichier de configuration de samba va"
      echo ":: --> s'ouvrir pour permettre les modifications"
      echo "----------------------------------------------"
      $CWD/pause_script.sh
      vim /etc/samba/smb.conf

      echo "------------------------------------------------"
	    echo ":: --> le fichier de configuration du parefeu va"
      echo ":: --> s'ouvrir pour permettre les modifications"
      echo "------------------------------------------------"
      $CWD/pause_script.sh
      vim /usr/local/sbin/firewall.sh

			# Exécuter le script
			bash -c /usr/local/sbin/firewall.sh 

  echo "----------------------------------"
  echo ":: Modification du parefeu OK ! ::"
  echo "----------------------------------"
      systemctl restart iptables.service

  echo "--------------------------------"
  echo ":: Lancement du serveur Samba ::"
  echo "--------------------------------"
      systemctl enable smb.service
      systemctl start smb.service
      systemctl enable nmb.service
      systemctl start nmb.service

  echo "-------------------------------------"
  echo ":: Le serveur Samba est en route ! ::"
  echo "-------------------------------------"

fi

exit 0

