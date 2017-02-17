# Please define your own values for those variables
VPN_PASSWORD=
VPN_USER=

# put your private ip here
PRIVATE_IP=`curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+'`

# automatic external IP lookup : (you can change it)
PUBLIC_IP=`curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+'`

#-----------------------------------------------------------------
#-----------------------------------------------------------------
#-----------------------------------------------------------------
#-----------------------------------------------------------------
IPSEC_PSK=$VPN_PASSWORD

if [ "$USER" != "root" ]; then
    echo "Please start the script with ROOT"
    exit
fi

if [ "$IPSEC_PSK" == "" ] || [ "$VPN_USER" == "" ]; then
    echo "Please Enter the IPSEC_PSK and VPN_USER variables."
    exit
fi

echo "------[ INSTALL ]------"
echo "user: $VPN_USER , password:[hidden], private ip: $PRIVATE_IP, public ip: $PUBLIC_IP"
echo "-----------------------"

# Install
apt-get install -y openswan
apt-get install -y xl2tpd

cat > /etc/ipsec.conf <<EOF
version 2.0

config setup
  dumpdir=/var/run/pluto/
  nat_traversal=yes
  virtual_private=%v4:10.0.0.0/8,%v4:192.168.0.0/16,%v4:172.16.0.0/12,%v4:25.0.0.0/8,%v6:fd00::/8,%v6:fe80::/10
  oe=off
  protostack=netkey
  nhelpers=0
  interfaces=%defaultroute

conn vpnpsk
  auto=add
  left=$PRIVATE_IP
  leftid=$PUBLIC_IP
  leftsubnet=$PRIVATE_IP/32
  leftnexthop=%defaultroute
  leftprotoport=17/1701
  rightprotoport=17/%any
  right=%any
  rightsubnetwithin=0.0.0.0/0
  forceencaps=yes
  authby=secret
  pfs=no
  type=transport
  auth=esp
  ike=3des-sha1
  phase2alg=3des-sha1
  dpddelay=30
  dpdtimeout=120
  dpdaction=clear
EOF

cat > /etc/ipsec.secrets <<EOF
$PUBLIC_IP  %any  : PSK "$IPSEC_PSK"
EOF

cat > /etc/xl2tpd/xl2tpd.conf <<EOF
[global]
port = 1701

;debug avp = yes
;debug network = yes
;debug state = yes
;debug tunnel = yes

[lns default]
ip range = 192.168.42.10-192.168.42.250
local ip = 192.168.42.1
require chap = yes
refuse pap = yes
require authentication = yes
name = l2tpd
;ppp debug = yes
pppoptfile = /etc/ppp/options.xl2tpd
length bit = yes
EOF

cat > /etc/ppp/options.xl2tpd <<EOF
ipcp-accept-local
ipcp-accept-remote
ms-dns 8.8.8.8
ms-dns 8.8.4.4
noccp
auth
crtscts
idle 1800
mtu 1280
mru 1280
lock
connect-delay 5000
EOF

cat > /etc/ppp/chap-secrets <<EOF
# Secrets for authentication using CHAP
# client    server  secret          IP addresses

$VPN_USER   l2tpd   $VPN_PASSWORD   *
EOF

iptables -t nat -A POSTROUTING -s 192.168.42.0/24 -o eth0 -j MASQUERADE
echo 1 > /proc/sys/net/ipv4/ip_forward

iptables-save > /etc/iptables.rules

cat > /etc/network/if-pre-up.d/iptablesload <<EOF
#!/bin/sh
iptables-restore < /etc/iptables.rules
echo 1 > /proc/sys/net/ipv4/ip_forward
exit 0
EOF

/etc/init.d/ipsec restart
/etc/init.d/xl2tpd restart
