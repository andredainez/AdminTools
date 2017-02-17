#!/bin/bash

FROM="en1"
TO="en0"

NETWORK="192.168.33.1/24"
GW="192.168.33.1"
MASK="255.255.255.0"

# ==============================

function on () {
    echo 1 > /proc/sys/net/ipv4/ip_forward
    ifconfig "$TO" down
    iptables -t nat -A POSTROUTING -s "$NETWORK" -o "$TO" -j MASQUERADE
    ifconfig "$TO" up
    ifconfig "$TO" "$GW" netmask "$MASK"
}

function off () {
    iptables --table nat --flush
    iptables --table nat --delete-chain
    ifconfig "$TO" down
    echo 0 > /proc/sys/net/ipv4/ip_forward
}

if [[ "$1" == "on" ]]; then
    off
    on
    exit 0
fi

if [[ "$1" == "off" ]]; then
    off
    exit 0
fi