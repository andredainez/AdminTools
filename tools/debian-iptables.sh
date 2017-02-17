#!/bin/bash

### BEGIN INIT INFO
# Provides: Iptables
# Required-Start: $local_fs $network
# Required-Stop: $local_fs $remote_fs
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: firewall
# Description: blocking shit.
### END INIT INFO

IPTABLES=/sbin/iptables

# Flush :
$IPTABLES -F
$IPTABLES -X
$IPTABLES -t filter -F
$IPTABLES -t filter -X
$IPTABLES -t nat -F
$IPTABLES -t nat -X
$IPTABLES -t mangle -F
$IPTABLES -t mangle -X

# DROP any connexions :
$IPTABLES -t filter -P INPUT DROP
$IPTABLES -t filter -P FORWARD DROP
$IPTABLES -t filter -P OUTPUT DROP
$IPTABLES -P INPUT DROP
$IPTABLES -P FORWARD DROP
$IPTABLES -P OUTPUT DROP
# -------------------------------------------------------------
# Anti Scan :
$IPTABLES -A INPUT -p tcp --tcp-flags ALL ALL -j DROP
$IPTABLES -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
$IPTABLES -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
$IPTABLES -A INPUT -p tcp --tcp-flags SYN,ACK,FIN,RST RST -j DROP

# Disable Forword:
echo "0" > /proc/sys/net/ipv4/ip_forward

# Anti Spoofing (active RP_FILTER) :
if [ -e /proc/sys/net/ipv4/conf/all/rp_filter ]; then
    for f in /proc/sys/net/ipv4/conf/*/rp_filter; do
        echo "1" > "$f"
    done
fi

# -------------------------------------------------
# Local zone
# Don't Break connexions:
$IPTABLES -t filter -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
$IPTABLES -t filter -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

# Enable loopback In/Out :
$IPTABLES -t filter -A INPUT -i lo -j ACCEPT
$IPTABLES -t filter -A OUTPUT -o lo -j ACCEPT
$IPTABLES -t filter -A INPUT -p tcp -s localhost -d localhost -j ACCEPT
$IPTABLES -t filter -A OUTPUT -p tcp -s localhost -d localhost -j ACCEPT

# ICMP (Ping) :

$IPTABLES -t filter -A INPUT -p icmp -j DROP
$IPTABLES -t filter -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT
$IPTABLES -t filter -A INPUT -p icmp --icmp-type destination-unreachable -j ACCEPT
$IPTABLES -t filter -A INPUT -p icmp --icmp-type time-exceeded -j ACCEPT
# $IPTABLES -t filter -A INPUT -p icmp --icmp-type echo-request -j ACCEPT

# DNS (apt-get) :
$IPTABLES -t filter -A OUTPUT -p udp --dport 53 -m state --state NEW -j ACCEPT
$IPTABLES -t filter -A OUTPUT -p tcp --dport 53 -m state --state NEW -j ACCEPT

# WWW (apt-get) :
$IPTABLES -t filter -A OUTPUT -p tcp -m multiport --dports 80,443 -m state --state NEW -j ACCEPT

# FTP (apt-get) :
$IPTABLES -t filter -A OUTPUT -p tcp -m multiport --dports 20,21 -m state --state NEW -j ACCEPT

# ---------------------------------------------
# Your zone :
$IPTABLES -t filter -A INPUT -p tcp --dport 22 -m state --state NEW -j ACCEPT #ssh_port
# $IPTABLES -t filter -A INPUT -p tcp --dport 80 -m state --state NEW -m recent --name BLACKLIST --set
# $IPTABLES -t filter -A INPUT -p tcp --dport 80 -m state --state NEW -m recent --name BLACKLIST --update --seconds 60  --hitcount 120 --rttl -j DROP
$IPTABLES -t filter -A INPUT -p tcp -m multiport --dports 80,443 -m state --state NEW -j ACCEPT

