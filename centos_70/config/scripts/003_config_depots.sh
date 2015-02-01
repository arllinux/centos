#!/bin/bash

# config_depots.sh
# JP Antinoux - Décembre 2014

CWD=$(pwd)

echo "----------------------------------------------------------"
echo ":: Ajustement des dépots officiels et du dépot rpmforge ::"
echo "----------------------------------------------------------"

# Réglage du dépot de base   
   cat $CWD/../repositories/CentOS-Base.repo >\
   /etc/yum.repos.d/CentOS-Base.repo

# Réglage du dépot rpmforge-release
   cat $CWD/../repositories/rpmforge.repo >\
   /etc/yum.repos.d/rpmforge.repo

# Réglage du dépot epel-release
   cat $CWD/../repositories/epel.repo >\
   /etc/yum.repos.d/epel.repo

# Nettoyage, mise à jour et vérification dépots
   yum repolist
   yum clean all
   yum check-update
   yum update

echo "-----------------------------"
echo ":: Mise à jour terminée... ::"
echo "-----------------------------"

exit 0
