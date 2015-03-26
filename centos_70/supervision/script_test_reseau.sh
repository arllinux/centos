#!/bin/bash
# ./script_test_reseau.sh
#
# Liste des fichiers de configuration du réseau sur le serveur

echo "# ======================================================" > resultat_reseau
echo "#  RESEAU ACTUEL - RESEAU ACTUEL - RESEAU ACTUEL -  #" >> resultat_reseau
echo "# --------------------         --------------------" >> resultat_reseau
echo "# ======================================================" >> resultat_reseau
echo "#" >> resultat_reseau
echo "#-----------------------------------------------------------" >> resultat_reseau
echo "# Liste des fichiers de configuration du réseau sur CentOS 7" >> resultat_reseau
echo "#-----------------------------------------------------------" >> resultat_reseau
echo "# Fichier /etc/hostname" >> resultat_reseau
cat /etc/hostname >> resultat_reseau
echo -e "---------------------------------------------\n " >> resultat_reseau
# echo "# Fichier /etc/hosts" >> resultat_reseau
cat /etc/hosts >> resultat_reseau
echo -e "---------------------------------------------\n " >> resultat_reseau
echo "# Fichier /etc/host.conf" >> resultat_reseau
cat /etc/host.conf >> resultat_reseau
echo -e "---------------------------------------------\n " >> resultat_reseau
echo "# Fichier /etc/sysconfig/network" >> resultat_reseau
cat /etc/sysconfig/network >> resultat_reseau
echo -e "---------------------------------------------\n " >> resultat_reseau
echo "# Fichier /etc/network" >> resultat_reseau
cat /etc/networks >> resultat_reseau
echo -e "---------------------------------------------\n " >> resultat_reseau
echo "# Fichier /etc/resolv.conf" >> resultat_reseau
cat /etc/resolv.conf >> resultat_reseau
echo -e "---------------------------------------------\n " >> resultat_reseau
<<<<<<< HEAD
if [ -f "/etc/sysconfig/network-scripts/ifcfg-enp2s0" ]; then
	echo "# Fichier /etc/sysconfig/network-scripts/ifcfg-enp2s0" >> resultat_reseau
	cat /etc/sysconfig/network-scripts/ifcfg-enp2s0 >> resultat_reseau
	echo -e "---------------------------------------------" >> resultat_reseau
 else
   if [ -f "/etc/sysconfig/network-scripts/ifcfg-enp3s0" ]; then
	echo "# Fichier /etc/sysconfig/network-scripts/ifcfg-enp3s0" >> resultat_reseau
	cat /etc/sysconfig/network-scripts/ifcfg-enp3s0 >> resultat_reseau
        echo -e "---------------------------------------------" >> resultat_reseau
     else
      if [ -f "/etc/sysconfig/network-scripts/ifcfg-eth0" ]; then
       	echo "# Fichier /etc/sysconfig/network-scripts/ifcfg-eth0" >> resultat_reseau
	cat /etc/sysconfig/network-scripts/ifcfg-eth0 >> resultat_reseau
	echo -e "---------------------------------------------" >> resultat_reseau
      fi
   fi
=======
if [ -d /etc/sysconfig/network-scripts/ifcfg-enp2s0 ];
  then
echo "# Fichier /etc/sysconfig/network-scripts/ifcfg-enp2s0" >> resultat_reseau
cat /etc/sysconfig/network-scripts/ifcfg-enp2s0 >> resultat_reseau
echo -e "---------------------------------------------" >> resultat_reseau
  else
echo "# Fichier /etc/sysconfig/network-scripts/ifcfg-eth0" >> resultat_reseau
cat /etc/sysconfig/network-scripts/ifcfg-eth0 >> resultat_reseau
echo -e "---------------------------------------------" >> resultat_reseau
>>>>>>> 36bbe92e86cefe30c1ab889449de24c056568348
fi
	vim resultat_reseau
exit 0
