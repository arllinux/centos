#!/bin/bash

# 007_dnsmasq.sh
# JP Antinoux - janvier 2015

#"""""""""""""""""""""""""""""""""""""""""""""""""""""""#
# Modifier les paramètres avant de lancer le script !!! #
#"""""""""""""""""""""""""""""""""""""""""""""""""""""""#

CWD=$(pwd)

[ $USER != "root" ] ;
if [ $? = "0" ]
    then
	echo "Pour exécuter ce script il faut être l'utilisateur root !"
else

	# Ouverture des ports du parefeu
        echo "--------------------------------------------------------"
        echo ":: Ouverture du parefeu tcp-udp : 53 - udp : 67 et 68 ::"
        echo "--------------------------------------------------------"
  # Ouvre le fichier firewall pour permettre les modifications      
        vim /usr/local/sbin/firewall.sh

  # Relance le service pour mettre à jour et figer les règles      
        systemctl restart firewall.service

        echo "------------------------------"
        echo ":: Configuration de dnsmasq ::"
        echo "------------------------------"
  # Ouvre le modèle de fichier dnsmasq.conf pour permettre les modifications      
        vim $CWD ../dnsmasq/dnsmasq.conf

  # Copie le fichier de configuration en "fichier.old"        
        cp /etc/dnsmasq.conf /etc/dnsmasq.conf.old

  # Envoie les données du modèle vers le fichier de configuration.      
        cat $CWD ../dnsmasq/dnsmasq.conf > /etc/dnsmasq.conf

        echo "--------------------------------"
        echo ":: Verouillage du resolv.conf ::"
        echo "--------------------------------"
  # Ecrit l'IP, le nom d'hote et le domaine du serveur dans le fichier hosts
        echo "192.168.0.250 centos7 centos7.labo2.arles" >> /etc/hosts

  # Ouvre le fichier hosts pour vérification        
        vim /etc/hosts
        
  # Ecrit la directive PERRDNS=no dans ifcfg-eth0 pour vérouillage du
  # resolv.conf
        echo "PEERDNS=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0
  
  # Ouvre le fichier ifcfg-eth0 pour vérification        
        vim /etc/sysconfig/network-scripts/ifcfg-eth0

        echo "------------------------------"
        echo ":: Activation de dnsmasq ::"
        echo "------------------------------"
        systemctl enable dnsmasq.service
        systemctl start dnsmasq.service
fi

exit 0
