#!/bin/bash
IPTABLES="/sbin/iptables"

# Limpiamos las reglas anteriores y ponemos los contadores a cero:
$IPTABLES -F
$IPTABLES -t nat -F
$IPTABLES -Z

# Establecemos la política por defecto de las cadenas de la tabla
# filter
$IPTABLES -P INPUT ACCEPT
$IPTABLES -P OUTPUT ACCEPT
$IPTABLES -P FORWARD ACCEPT
$IPTABLES -t nat -P PREROUTING ACCEPT
$IPTABLES -t nat -P POSTROUTING ACCEPT

/sbin/iptables -P FORWARD ACCEPT
#iptables -t nat -A PREROUTING -i eth1 -p tcp --dport 80 -j REDIRECT --to-port 8080
/sbin/iptables --table nat -A POSTROUTING -s 172.16.0.0/16 -o eth0 -j MASQUERADE
#/sbin/iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 80 -j DNAT --to-destination 172.17.0.75:80
echo 1 > /proc/sys/net/ipv4/ip_forward
