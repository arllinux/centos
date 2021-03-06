#!/bin/sh
#
# firewall.sh
# JP Antinoux - Mai 2015
# Les programmes d'administration système installés en local doivent être
# placés dans /usr/local/sbin. 

IPT=$(which iptables)
MOD=$(which modprobe)
SYS=$(which sysctl)
INET=enp2s0
ETH=192.168.0.250

       #---------------#
       # Tout accepter #
       #---------------#

       for TABLE in filter mangle
       do
          $IPT -t $TABLE -P INPUT ACCEPT
          $IPT -t $TABLE -P FORWARD ACCEPT
       done


       for TABLE in filter nat mangle
       do
          $IPT -t $TABLE -P OUTPUT ACCEPT
       done


       for TABLE in nat mangle
       do
          $IPT -t $TABLE -P PREROUTING ACCEPT
          $IPT -t $TABLE -P POSTROUTING ACCEPT
       done

       #--------------------------------#
       # Remettre les compteurs à zéro  #
       #--------------------------------#
        
       for TABLE in filter nat mangle
       do
          $IPT -t $TABLE -Z
       done

       #-----------------#
       # Initialisations #
       #-----------------#

       # Vidage et suppression des règles existantes :
       for TABLE in filter nat mangle
       do
          $IPT -t $TABLE -F
          $IPT -t $TABLE -X
       done

       # Modifications des politiques par défaut :
       $IPT -P INPUT DROP
       $IPT -P OUTPUT ACCEPT
       $IPT -P FORWARD ACCEPT

       # Relais des paquets (yes/no)
       # MASQ=yes

       #--------------------------------#
       # Traitements interfaces locales #
       #--------------------------------#
       
       # Autoriser la boucle locale :
       # $IPT -A INPUT -i lo -j ACCEPT

       # Ping :
       # $IPT -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
       # $IPT -A INPUT -p icmp --icmp-type time-exceeded -j ACCEPT
       # $IPT -A INPUT -p icmp --icmp-type destination-unreachable -j ACCEPT

       # Connexions établies :
       # $IPT -A INPUT -m state --state ESTABLISHED -j ACCEPT

       # FTP local :
       # $MOD ip_conntrack_ftp
       # $IPT -A INPUT -p tcp -i $INET --dport 21 -j ACCEPT

       # SSH local :
       # $IPT -A INPUT -p tcp -i $INET --dport 22 -j ACCEPT

       # SSH limité en provenance de l'extérieur :
       # $IPT -A INPUT -p tcp -i $INET --dport 22 -m state --state NEW -m recent --set --name SSH
       # $IPT -A INPUT -p tcp -i $INET --dport 22 -m state --state NEW -m recent --update --seconds 60 --hitcount 2 --rttl --name SSH -j DROP

       # DNS :
       # $IPT -A INPUT -p tcp -i $INET --dport 53 -j ACCEPT
       # $IPT -A INPUT -p udp -i $INET --dport 53 -j ACCEPT

       # DHCP :
       # $IPT -A INPUT -p udp -i $INET --dport 67:68 -j ACCEPT

       # HTTP :
       # $IPT -A INPUT -p tcp -i $INET --dport 80 -j ACCEPT

       # HTTPS :
       # $IPT -A INPUT -p tcp -i $INET --dport 443 -j ACCEPT

       # NTP :
       # $IPT -A INPUT -p udp -i $INET --dport 123 -j ACCEPT

       # Samba :
       # $IPT -A INPUT -p udp -i $INET --dport 137:138 -j ACCEPT
       # $IPT -A INPUT -p tcp -i $INET --dport 139 -j ACCEPT
       # $IPT -A INPUT -p tcp -i $INET --dport 445 -j ACCEPT

       # CUPS :
       # $IPT -A INPUT -p tcp -i $INET --dport 631 -j ACCEPT
       # $IPT -A INPUT -p udp -i $INET --dport 631 -j ACCEPT

       # NFS :
       # $IPT -A INPUT -p tcp -i $INET --dport 111 -j ACCEPT
       # $IPT -A INPUT -p udp -i $INET --dport 111 -j ACCEPT
       # $IPT -A INPUT -p tcp -i $INET --dport 2049 -j ACCEPT
       # $IPT -A INPUT -p udp -i $INET --dport 2049 -j ACCEPT
       # $IPT -A INPUT -p tcp -i $INET --dport 32765:32769 -j ACCEPT
       # $IPT -A INPUT -p udp -i $INET --dport 32765:32769 -j ACCEPT

       # NIS :
       # $IPT -A INPUT -p tcp -i $INET --dport 834 -j ACCEPT
       # $IPT -A INPUT -p udp -i $INET --dport 834 -j ACCEPT

       # Squid :
       # $IPT -A INPUT -p tcp -i $INET --dport 3128 -j ACCEPT
       # $IPT -A INPUT -p udp -i $INET --dport 3128 -j ACCEPT

       # Proxy transparent :
       # $IPT -A PREROUTING -t nat -i $INET -p tcp ! -d $ETH \
       # --dport 80 -j REDIRECT --to-port 3128

       # MPD :
       # $IPT -A INPUT -p tcp -i $INET --dport 8000 -j ACCEPT
       
       # Activer le relais des paquets
       # if [ $MASQ = 'yes' ]; then
         # $IPT -t nat -A POSTROUTING -o $ETH -s $ETH -j MASQUERADE
         # $SYS -q -w net.ipv4.ip_forward=1
       # fi

       # Enregistrer les connexions refusées :
       # $IPT -A INPUT -j LOG --log-prefix "+++ IPv4 packet rejected +++"
       # $IPT -A INPUT -j REJECT

       # Enregistrer la configuration :
        /sbin/service iptables save
exit 0
