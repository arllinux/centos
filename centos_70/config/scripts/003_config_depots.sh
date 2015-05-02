#!/bin/bash

# 003_config_depots.sh
# JP Antinoux - Décembre 2014

CWD=$(pwd)

if [ $USER != "root" ] ;
    then
	echo "Pour exécuter ce script il faut être l'utilisateur root !"
else

		echo "----------------------------------------------------------"
		echo ":: Ajustement des dépots officiels et du dépot rpmforge ::"
		echo "----------------------------------------------------------"

	# Réglage du dépot de base   
  	cat $CWD/../repositories/CentOS-Base.repo >\
  	/etc/yum.repos.d/CentOS-Base.repo
  
    mkdir RPMS
    cd RPMS
  
	# Téléchargement du paquet rpmforge et installation
		lynx http://apt.sw.be/redhat/el7/en/x86_64/rpmforge/RPMS/
    paquet=$(echo rpmforge*)
    rpm -Uvh $paquet
    
	# Réglage du dépot rpmforge-release
  	cat $CWD/../repositories/rpmforge.repo >\
  	/etc/yum.repos.d/rpmforge.repo
  
  # Installation du paquet epel-release
    yum -y install epel-release

	# Réglage du dépot epel-release
   cat $CWD/../repositories/epel.repo >\
  /etc/yum.repos.d/epel.repo

	# Nettoyage, mise à jour et vérification dépots
	yum repolist
  yum clean all
  yum check-update
  yum update
	# Installation de deux utilitaires
	yum -y install logwatch glances
  
	echo "-----------------------------------"
	echo ":: Mise à jour terminée... ::"
	echo ":: Logwatch et glances installés ::"
	echo "-----------------------------------"
fi
exit 0
