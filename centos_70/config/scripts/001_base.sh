#!/bin/bash

# 001_base.sh
# JP Antinoux - décembre 2014

FILE_U='invite_user'
FILE_R='invite_root'
RC_ROOT='/root/.bashrc'
CWD=$(pwd)

[ $USER != "root" ] ;
if [ $? = "0" ]
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
        echo "-----------------------------------------"
        echo ":: Installation outils de base. ::"
        echo "-----------------------------------------"
        # TOOLS=$(egrep -v '(^\#)|(^\s+$)' $CWD/../bases_install/paquets-base)
        TOOLS=$(egrep -v '(^\#)' $CWD/../bases_install/paquets-base)
        yum -y install $TOOLS

		# Personnalisation de screen
        echo "------------------------------"
        echo ":: Peronnalisation de scree ::"
        echo "------------------------------"
				cat $CWD/../screen/screenrc > /etc/screenrc
				
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
        echo "-----------------------------------"
        echo ":: Activation du service iptables ::"
        echo "-----------------------------------"
        systemctl enable iptables
        systemctl start iptables

    # Activation de la souris en console 
        echo ":: Activation de la souris en console. ::"
        systemctl start gpm.service 
        systemctl enable gpm.service

    # Désactivation de l'ipv6
        echo "-----------------------------"
        echo ":: Desactivation de l'IPV6 ::"
        echo "-----------------------------"
	      cat $CWD/../firewall/sysctl.conf > /etc/sysctl.conf

    # Désactivation de SElinux 
        echo ":: Désactivation de SELinux ::"
        cat $CWD/../selinux/selinux > /etc/sysconfig/selinux

 		# Activer la coloration de l'invite root
		basch -c source $RC_ROOT

        echo "-------------------------------"
      	echo ":: Réglages de base terminés ::"
        echo "-------------------------------"
fi

exit 0
