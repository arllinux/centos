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
     vim $WAY$PREFIX$IFACE
     vim /etc/sysconfig/network
      if [ $STOP = "0" ]; then
         exit
       fi
  fi  
done

exit 0

