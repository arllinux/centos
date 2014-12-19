#!/bin/bash

# install_firewall.sh

CWD=$(pwd)

# Mettre en place l'exécutable dans le répertoire :
# /usr/local/sbin
	cp $CWD/firewall.sh /usr/local/sbin/firewall.sh

# Exécuter le script pour enregistrer les règles du parefeu
	cd /usr/local/sbin
	chmod +x firewall.sh
	./firewall.sh

# Voir les règles du parefeu
	iptables -L -n

exit 0

