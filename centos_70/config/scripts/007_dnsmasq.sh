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
        vim /usr/local/sbin/firewall.sh
        systemctl restart firewall.service

        echo "------------------------------"
        echo ":: Configuration de dnsmasq ::"
        echo "------------------------------"
        vim $CWD ../dnsmasq/dnsmasq.conf
        cp /etc/dnsmasq.conf /etc/dnsmasq.conf.old
        cat $CWD ../dnsmasq/dnsmasq.conf > /etc/dnsmasq.conf

        echo "--------------------------------"
        echo ":: Verouillage du resolv.conf ::"
        echo "--------------------------------"
        echo "nameserver 192.168.0.250" > /etc/resolv.conf
        vim /etc/resolv.conf
      
        echo "192.168.0.250 centos7 centos7.labo2.arles" >> /etc/hosts
        vim /etc/hosts
        
        echo "PEERDNS=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0
        vim /etc/sysconfig/network-scripts/ifcfg-eth0

        echo "------------------------------"
        echo ":: Activation de dnsmasq ::"
        echo "------------------------------"
        systemctl enable dnsmasq.service
        systemctl start dnsmasq.service
fi

exit 0
