#!/bin/bash

# 001_base.sh
# JP Antinoux - décembre 2014

FILE_U='invite_user'
FILE_R='invite_root'
RC_ROOT='/root/.bashrc'
CWD=$(pwd)

if [ $USER != "root" ] ;
    then
	echo "Pour exécuter ce script il faut être l'utilisateur root !"
else
		# Configurer pour un utilisateur exitant (pour serveur dedibox)
		read -p 'Avez-vous déjà un utilisateur simple à configurer ? : oui/non '
		oui
    if [ $oui = "oui" ] then
		
		# Vérification du nom d'utilisateur
       read -p 'Utilisateur (login) à personnaliser : ' nom
       while [ -z $nom ]; do
       echo "Veuillez saisir votre nom"
       read nom
       done
       cat /etc/passwd | grep bash | awk -F ":" '{print $1}' | grep -w $nom > /dev/null
 				if [ $? = "0" ]
   				then
       echo ":: Configuration invite de commande pour l'utilisateur courant. ::"
       cat $CWD/../bash/invite_users > /home/$nom/.bashrc
    
    # Configuration de Vim
        echo "---------------------------"
        echo ":: Configuration de Vim. ::"
        echo "---------------------------"
	cat $CWD/../vim/vimrc > /etc/vimrc

    # Personnalisation invite pour les futurs utilisateurs
        echo ":: Personnalisation invite pour les futurs utilisateurs. ::"
        cat $CWD/../bash/$FILE_U > /etc/skel/.bashrc

    # Personnalisation pour l'utiisateur actif
        echo ":: Personnalisation invite pour l'utilisateurs actif. ::"
        cat $CWD/../bash/$FILE_U > /home/$nom/.bashrc

    # Installation invite root
        echo "-----------------------------------------"
        echo ":: Coloration invite de commande root. ::"
        echo "-----------------------------------------"
	      cat $CWD/../bash/$FILE_R > "$RC_ROOT"

    # Installation de quelques outils en ligne de commande
        echo "-----------------------------------------"
        echo ":: Installation outils de base. ::"
        echo "-----------------------------------------"
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
        echo "-----------------------------------"
        echo ":: Activation du service iptables ::"
        echo "-----------------------------------"
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

    # Lien symbolique de eZServerMonitor.sh vers diag -a
        echo "------------------------------"
        echo ":: Mise en place de diag -a ::"
        echo "------------------------------"
        mkdir /root/bin
        ln -s /root/centos/centos_70/eZServerMonitor.sh /root/bin/diag
        diag -a

 	# Activer la coloration de l'invite root et utilisateur
	bash -c source $RC_ROOT
	bash -c source /home/$nom/.bashrc

        echo "-------------------------------"
      	echo ":: Réglages de base terminés ::"
        echo "-------------------------------"
  else
        echo "Ce nom d'utilisateur n'existe pas. Réessayez !"
 fi
fi

exit 0
