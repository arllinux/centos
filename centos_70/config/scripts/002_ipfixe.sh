#!/bin/bash

# 002_ipfixe.sh
# JP Antinoux - Avril 2015

CWD=$(pwd)
WAY="/etc/sysconfig/network-scripts/"
PREFIX="ifcfg-"
IFACES="enp2s0 enp3s7 eth0"

for IFACE in $IFACES; do
   if [ -f $WAY$PREFIX$IFACE ]; then
     STOP=$?
     cat $CWD/../eth/ifcfg-xxx >> $WAY$PREFIX$IFACE
     cat $CWD/../eth/network >> /etc/sysconfig/network

		 echo ":: --> le fichier de configuration de l'interface réseau va"
     echo ":: -- > s'ouvrir pour permettre les modifications"
		 $CWD/chrono.sh
     vim $WAY$PREFIX$IFACE

		 echo ":: --> le fichier de configuration du réseau va"
     echo ":: -- > s'ouvrir pour permettre les modifications"
		 $CWD/chrono.sh
     vim /etc/sysconfig/network
      if [ $STOP = "0" ]; then
         exit
       fi
  fi  
done

exit 0

