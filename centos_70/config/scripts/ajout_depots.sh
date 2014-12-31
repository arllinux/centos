#!/bin/bash

# /usr/share/debian/squeeze/config/apt/ajout_depots


# Dernières modif 13/07/2012 - 22/08/2012

CWD=$(pwd)


echo ":: Ajustement des dépots officiels et du dépot rpmforge::"

   cat $CWD/../repositories/Centos-Base.repo >
   /etc/yum.repos.d/Centos-Base.repo

   cat $CWD/../repositories/rpmforge.repo >
   /etc/yum.repos.d/rpmforge.repo

echo ":: Mise à jour terminée... ::"

