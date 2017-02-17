#!/bin/bash

FROM="en1"
TO="en0"

NETWORK="192.168.33.1/24"
GW="192.168.33.1"
MASK="255.255.255.0"

# ==============================

function on {
    sysctl -w net.inet.ip.forwarding=1
    sysctl -w net.inet.ip.fw.enable=1
    ifconfig "$TO" down
    natd -port 8668 -interface "$FROM" -dynamic
    ifconfig "$TO" "$GW" netmask "$MASK"
    ifconfig "$TO" up
    ipfw add 500 divert 8668 all from any to any via "$FROM"
}

function off {
    ipfw -q flush
    ifconfig "$TO" down
    killall QUIT natd
    sysctl -w net.inet.ip.forwarding=0
    sysctl -w net.inet.ip.fw.enable=0
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