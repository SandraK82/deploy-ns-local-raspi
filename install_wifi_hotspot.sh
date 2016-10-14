#!/bin/sh

# based on http://elinux.org/RPI-Wireless-Hotspot

sudo apt-get install hostapd udhcpd

# TODO: change the config files

sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
#sudo service hostapd start
#sudo service udhcpd start