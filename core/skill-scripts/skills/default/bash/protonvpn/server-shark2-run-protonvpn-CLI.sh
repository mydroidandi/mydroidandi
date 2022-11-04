#!/bin/bash
# File: desktop-shark-run-protonvpn-CLI.sh
# Description: Script to run Protonvpn in a terminal server

# Requires:
# ssh
# screen: software to detach and re-attach terminal sessions yet open.
# openvpn
# openvpn updated from ProtonVPN documentation
# Protonvpn-cli package for debian (.deb)
# gdebi
# resolvconf
# ProtonVPN user account (Free account works)
# OpenVPN IKEv2 username and password for manual IKEv2 login or
# strongswan, libstrongswan-extra-plugins, and/or libcharon-extra-plugins
# packages, cert, and setup for ipsec and connection to the IKEv2 protocol
# without authentication. 

# The Commbase directory:
# Due to the loss of the Commbase application scope here, it must be re-assigned
COMMBASE=$HOME/Developer
#COMMBASE=$HOME

# The ProtonVPN user:
source $COMMBASE/Commbase/.env
#PROTONVPNUSER="PROTONVPN-USERNAME"

# A connection to the VPN server will now be established. To check your connection status, enter:
#protonvpn-cli status (or protonvpn-cli s)
# To disconnect, enter:
#protonvpn-cli disconnect (or protonvpn-cli d)
# Alternatively, you can disconnect using NetworkManager (if set up for using PRoton VPN). 

# Kill switch:
# The ProtonVPN official Linux CLI includes a kill switch. The basic Kill Switch will block all your
# internet connections when the VPN is running and the connection to one of our servers fails. To
# enable it, enter:
protonvpn-cli ks --on
# The CLI also features a Permanent Kill Switch. This prevents all internet connections unless
# the VPN is running and connected to one of our servers. To enable it, enter:
#protonvpn-cli ks --permanent
# You can disable the Kill Switch
#protonvpn-cli ks --off

# After logging in the first time ProtonVPN stores the password
# but user must be typed in (PROTONVPN-USERNAME):
protonvpn-cli login $PROTONVPN_CLI_USERNAME

# Connect manually to a specific server in the terminal using openvpn:
# Enter credentials from https://account.protonvpn.com/account
# If you want to enable the ProtonVPN ad blocker (NetShield):
# Use: "xSvYsmmJUrvvk0Ng+f1" as username to enable anti-malware filtering
# Use: "xSvYsmmJUrvvk0Ng+f2" as username to additionally enable ad-blocking filtering.
# Reset the user credential if the current credentials don't work
# The system is going to ask for the sudo password before the authentication
# credentials
#sudo openvpn ~/ProtonVPN_server_configs/jp-free-04.protonvpn.com.tcp.ovpn
#sudo openvpn ./ProtonVPN_server_configs/jp-free-04.protonvpn.com.tcp.ovpn
sudo openvpn $COMMBASE/Commbase/protonvpn/ProtonVPN_server_configs/jp-free-04.protonvpn.com.udp.ovpn
# If you connect well you see the message "Sequence completed"

# Test connection:
# Verify my VPN Private Network IP address (from the VPN server set up, 
# don't confuse it with a public IP). It also tells us whether yes or not
# the host is connected to the VPN:
ip addr show
# Output example:
# -------------------------------------------------------------
# 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
#     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
#     inet 127.0.0.1/8 scope host lo
#        valid_lft forever preferred_lft forever
#     inet6 ::1/128 scope host 
#        valid_lft forever preferred_lft forever
# 2: enp2s14: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast state DOWN group default qlen 1000
#     link/ether 00:1c:f0:a7:a8:57 brd ff:ff:ff:ff:ff:ff
# 3: enp2s12: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UNKNOWN group default qlen 1000
#     link/ether 00:01:02:c5:ff:48 brd ff:ff:ff:ff:ff:ff
#     inet 192.168.100.45/24 brd 192.168.100.255 scope global dynamic noprefixroute enp2s12
#        valid_lft 83450sec preferred_lft 83450sec
#     inet 10.1.26.120/32 scope global enp2s12
#        valid_lft forever preferred_lft forever
#     inet6 fe80::201:2ff:fec5:ff48/64 scope link noprefixroute 
#        valid_lft forever preferred_lft forever
# 4: enp2s8: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast state DOWN group default qlen 1000
#     link/ether 00:02:55:bf:da:90 brd ff:ff:ff:ff:ff:ff
# -------------------------------------------------------------

# From the server host:
# Google local IP
#$ traceroute www.yahoo.com has to show us the route from the VPN address location to the yahoo servers.
#$ traceroute www.yahoo.com no VPN connection active has to show us a different route from the local address
# to the yahoo servers.

# To log out from the CLI:
#$ protonvpn-cli logout

# See more options
#$ protonvpn-cli help