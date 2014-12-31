#!/bin/bash

# config_depots.sh
# JP Antinoux - Décembre 2014

CWD=$(pwd)

echo "----------------------------------------------------------"
echo ":: Ajustement des dépots officiels et du dépot rpmforge ::"
echo "----------------------------------------------------------"
   cat $CWD/../repositories/CentOS-Base.repo >\
   /etc/yum.repos.d/CentOS-Base.repo

   cat $CWD/../repositories/rpmforge.repo >\
   /etc/yum.repos.d/rpmforge.repo

   yum repolist
   yum clean all
   yum check-update
   yum update

echo "-----------------------------"
echo ":: Mise à jour terminée... ::"
echo "-----------------------------"

exit 0
