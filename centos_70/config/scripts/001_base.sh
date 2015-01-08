#!/bin/bash

# 001_base.sh
# JP Antinoux - décembre 2014

FILE_U=invite_user
FILE_R=invite_root
RC_ROOT=/root/.bashrc
CWD=$(pwd)

[ $USER != "root" ]
if [ $? = "0" ]
    then
	echo "Pour exécuter ce script il faut être l'utilisateur root !"
else

	# Configuration de Vim
        echo "---------------------------"
        echo ":: Configuration de Vim. ::"
        echo "---------------------------"
	      cat $CWD/../vim/vimrc > /etc/vimrc
	      chown root:root /etc/vimrc
	      chmod 0644 /etc/vimrc

	# Personnalisation invite pour les futurs utilisateurs
	      echo ":: Personnalisation invite pour les futurs utilisateurs. ::"
	      cat $CWD/../bash/$FILE_U > /etc/skel/.bashrc
	      chown root:root /etc/skel/.bashrc
	      chmod 0644 /etc/skel/.bashrc

	# Installation invite root
        echo "-----------------------------------------"
        echo ":: Coloration invite de commande root. ::"
        echo "-----------------------------------------"
	      cat $CWD/../bash/$FILE_R > "$RC_ROOT"
	      chown root:root "$RC_ROOT"
	      chmod 0644 "$RC_ROOT"

	# Installation de quelques outils en ligne de commande
        echo ":: Installation outils de base. ::"
        TOOLS=$(egrep -v '(^\#)|(^\s+$)' $CWD/../bases_install/paquets-base)
        yum -y install $TOOLS

  # Désactivation de firewalld
        echo "---------------------------------"
        echo ":: Désactivation de firewalld. ::"
        echo "---------------------------------"
        systemctl stop firewalld
        systemctl disable firewalld
        yum remove firewalld

        echo ":: Désactivation de l'ipv6 ::"
        systemctl stop ip6tables.service
        systemctl disable ip6tables.service

        echo "----------------------------"
        echo ":: Activation d'iptables. ::"
        echo "----------------------------"
        systemctl enable iptables.service
        systemctl restart iptables.service

        echo ":: Désactivation du NetworkManager ::"
        systemctl stop NetworkManager
        systemctl disable NetworkManager

        echo "-----------------------------------"
        echo ":: Activation du service network ::"
        echo "-----------------------------------"
        chkconfig network on
        systemctl start network.service

        echo ":: Activation de la souris en console. ::"
        systemctl enable gpm.service 
        systemctl start gpm.service

        echo "------------------------------"
        echo ":: Désactivation de SELinux ::"
        echo "------------------------------"
	      cat $CWD/../selinux/selinux > /etc/sysconfig/selinux
	      chown root:root /etc/sysconfig/selinux
	      chmod 0644 /etc/sysconfig/selinux

        echo "-------------------------------"
      	echo ":: Réglages de base terminés ::"
        echo "-------------------------------"
fi

exit 0
