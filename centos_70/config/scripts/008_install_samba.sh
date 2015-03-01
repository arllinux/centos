#!/bin/bash

# 010_install_samba.sh
#
# JP Antinoux - Janvier 2015

#'''''''''''''''''''''''''''''''''''''''''''''''''''#
# Modifier les paramètres avant de lancer le script #
#'''''''''''''''''''''''''''''''''''''''''''''''''''#

CWD=$(pwd)

[ $USER != "root" ]
if [ $? = "0" ]
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
  read -p "Pour créer un seul répertoire taper 1 sinon taper 2 :" numrep
  if [ $numrep = 1 ]
    then
      mkdir -pv -m 1777 /srv/samba/public
    else
      mkdir -pv -m 1777 /srv/samba/{public,confidentiel}
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
      cat $CWD/ ../samba/etc/cron.weekly/samba_trash.sh.template > /etc/cron.weekly/samba_trash.sh
      chmod 644 /etc/cron.weekly/samba_trash.sh

  echo "----------------------------------------------"
  echo ":: Adaptation des fichiers de configuration ::"
  echo "----------------------------------------------"
      vim /etc/samba/smb.conf

  echo "---------------------------------"
  echo ":: Ouvrir les ports pour Samba ::"
  echo "---------------------------------"
      vim /usr/local/sbin/firewall.sh
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

