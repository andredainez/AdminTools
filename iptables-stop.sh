#!/bin/bash

/sbin/iptables -F
/sbin/iptables -X
/sbin/iptables -t filter -F
/sbin/iptables -t filter -X
/sbin/iptables -t nat -F
/sbin/iptables -t nat -X
/sbin/iptables -t mangle -F
/sbin/iptables -t mangle -X

/sbin/iptables -t filter -P INPUT ACCEPT
/sbin/iptables -t filter -P FORWARD ACCEPT
/sbin/iptables -t filter -P OUTPUT ACCEPT
/sbin/iptables -P INPUT ACCEPT
/sbin/iptables -P FORWARD ACCEPT
/sbin/iptables -P OUTPUT ACCEPT
