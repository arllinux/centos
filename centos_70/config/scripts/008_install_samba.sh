#!/bin/bash

# 010_install_samba.sh
#
# JP Antinoux - Janvier 2015

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

  echo ":: Création de 2 répertoires : public et confidentiel ::"
      mkdir -pv -m 1777 /srv/samba/{public,confidentiel}

  echo "-------------------------------------------------"
  echo ":: Mise en place des fichiers de configuration ::"
  echo "-------------------------------------------------"
      cp /etc/samba/smb.conf /etc/samba/smb.conf_old
      cat $CWD/ ../samba/etc/samba/smb.conf.template > /etc/samba/smb.conf
      chmod 644 /etc/samba/smb.conf

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
  
  echo "----------------------------------"
  echo ":: Modification du parefeu OK ! ::"
  echo "----------------------------------"
      systemctl restart firewall.service

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

