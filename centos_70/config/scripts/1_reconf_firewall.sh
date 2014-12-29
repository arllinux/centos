#!/bin/bash

# 1_reconf_firewall.sh

CWD=$(pwd)


# Exécuter le script pour enregistrer les règles du parefeu
  systemctl disable iptables.service
  system-config-firewall-tui
  systemctl enable iptable.service
  iptables -P INPUT DROP
  /sbin/service iptables save
# Voir les règles du parefeu
	iptables -L -n

exit 0

