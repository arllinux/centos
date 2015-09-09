#!/bin/bash

# 001_base.sh
# JP Antinoux - décembre 2014 - juin 2015

FILE_U='invite_user'
FILE_R='invite_root'
RC_ROOT='/root/.bashrc'
CWD=$(pwd)

if [ $USER != "root" ] ;
    then
	echo "Pour exécuter ce script il faut être l'utilisateur root !"
else
    
    # Configuration de Vim
        echo "---------------------------"
        echo ":: Configuration de Vim. ::"
        echo "---------------------------"
	      cat $CWD/../vim/vimrc > /etc/vimrc

    # Personnalisation invite pour les futurs utilisateurs
        echo ":: Personnalisation invite pour les futurs utilisateurs. ::"
        cat $CWD/../bash/$FILE_U > /etc/skel/.bashrc

    # Installation invite root
        echo "-----------------------------------------"
        echo ":: Coloration invite de commande root. ::"
        echo "-----------------------------------------"
	      cat $CWD/../bash/$FILE_R > "$RC_ROOT"

    # Installation de quelques outils en ligne de commande
        echo "----------------------------------"
        echo ":: Installation outils de base. ::"
        echo "----------------------------------"
        TOOLS=$(egrep -v '(^\#)' $CWD/../bases_install/paquets-base)
        yum -y install $TOOLS

    # Désactivation de firewalld
        echo "---------------------------------"
        echo ":: Désactivation de firewalld. ::"
        echo "---------------------------------"
        systemctl stop firewalld
        systemctl disable firewalld
        yum -y remove firewalld

    # Désactivation du NetworkManager 
        echo ":: Désactivation du NetworkManager ::"
        systemctl stop NetworkManager
        systemctl disable NetworkManager
        yum -y remove NetworkManager

    # Activation du service iptables (parefeu du noyau)
        echo "------------------------------------"
        echo ":: Activation du service iptables ::"
        echo "------------------------------------"
        systemctl enable iptables
        systemctl start iptables

    # Désactivation de l'ipv6
        echo "-----------------------------"
        echo ":: Desactivation de l'IPV6 ::"
        echo "-----------------------------"
	      cat $CWD/../firewall/sysctl.conf > /etc/sysctl.conf

    # Désactivation de SElinux 
        echo ":: Désactivation de SELinux ::"
        cat $CWD/../selinux/selinux > /etc/sysconfig/selinux

 		 # Activer la coloration de l'invite root
				bash -c source "$RC_ROOT"

    # Lien symbolique de eZServerMonitor.sh vers diag -a
        echo "------------------------------"
        echo ":: Mise en place de diag -a ::"
        echo "------------------------------"
        mkdir /root/bin
        ln -s /root/centos/centos_70/eZServerMonitor.sh /root/bin/diag
        diag -a

        echo "-------------------------------"
      	echo ":: Réglages de base terminés ::"
        echo "-------------------------------"
fi

exit 0
