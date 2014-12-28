#!/bin/bash

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
        echo ":: Configuration de Vim. ::"
	      cat $CWD/../vim/vimrc > /etc/vimrc
	      chown root:root /etc/vimrc
	      chmod 0644 /etc/vimrc

	# Personnalisation invite pour les futurs utilisateurs
	      echo ":: Personnalisation invite pour les futurs utilisateurs. ::"
	      cat $CWD/../bash/$FILE_U > /etc/skel/.bashrc
	      chown root:root /etc/skel/.bashrc
	      chmod 0644 /etc/skel/.bashrc

	# Installation invite root
        echo ":: Coloration invite de commande root. ::"
	      cat $CWD/../bash/$FILE_R > "$RC_ROOT"
	      chown root:root "$RC_ROOT"
	      chmod 0644 "$RC_ROOT"

	# Mise en place du bootsplash
	#echo ":: Mise en place du bootsplash. ::"
	#cp $CWD/../bootsplash/wwl.tga /boot/grub/
        
	# Installation de quelques outils en ligne de commande
        echo ":: Installation outils de base. ::"
        TOOLS=$(egrep -v '(^\#)|(^\s+$)' $CWD/../bases_install/paquets-base)
        yum -y install $TOOLS

  # Désactivation de firewalld
        echo ":: Désactivation de firewalld. ::"
        systemctl stop firewalld
        systemctl disable firewalld
        echo ":: Activation d'iptables. ::"
        systemctl restart iptables.service
        systemctl enable iptables.service
        echo ":: Activation de la souris en console. ::"
        systemctl start gpm 
	echo ":: Réglages de base terminés ::"
fi

exit 0
