#!/bin/bash

# 007_dnsmasq.sh
# JP Antinoux - janvier 2015

#"""""""""""""""""""""""""""""""""""""""""""""""""""""""#
# Modifier les paramètres avant de lancer le script !!! #
#"""""""""""""""""""""""""""""""""""""""""""""""""""""""#

CWD=$(pwd)

if [ $USER != "root" ] ;
    then
	echo "Pour exécuter ce script il faut être l'utilisateur root !"
else

	# Ouverture des ports du parefeu
        echo "--------------------------------------------------------"
        echo ":: Ouverture du parefeu tcp-udp : 53 - udp : 67 et 68 ::"
        echo "--------------------------------------------------------"
  # Ouvre le fichier firewall pour permettre les modifications      
        vim /usr/local/sbin/firewall.sh
        
	# Exécuter le script
				bash -c /usr/local/sbin/firewall.sh

  # Relance le service pour mettre à jour et figer les règles      
        systemctl restart iptables.service

  # Ouvre le modèle de fichier dnsmasq.conf pour permettre les modifications      
        echo "------------------------------"
        echo ":: Configuration de dnsmasq ::"
        echo "------------------------------"
        vim $CWD/../dnsmasq/dnsmasq.conf

  # Copie le fichier de configuration en "fichier.old"        
        cp /etc/dnsmasq.conf /etc/dnsmasq.conf.old

  # Envoie les données du modèle vers le fichier de configuration.      
        cat $CWD/../dnsmasq/dnsmasq.conf > /etc/dnsmasq.conf

  # Mise en place de l'encapsuleur TCP
        echo "----------------------------------------"
        echo ":: Mise en place de l'encapsuleur tcp ::"
        echo "----------------------------------------"
        vim $CWD/../firewall/hosts.allow
        cat $CWD/../firewall/hosts.allow > /etc/hosts.allow
        cat $CWD/../firewall/hosts.deny > /etc/hosts.deny

  # Relancer le service iptatble
        systemctl restart iptables.service

        echo "------------------------------"
        echo ":: Activation de dnsmasq ::"
        echo "------------------------------"
        systemctl enable dnsmasq.service
        systemctl start dnsmasq.service

        echo "----------------------------------------"
        echo ":: Modifier manuellement les fichiers : "
        echo ":: /etc/hosts et /etc/resolv.conf :: "
        echo "----------------------------------------"
fi

exit 0
