#!/bin/bash

# Firewall Configuration Script
# Generated on Fri Feb 28 10:53:32 PM EST 2025
# This script configures iptables to:
# 1. Block all outgoing traffic by default
# 2. Allow outgoing traffic only to pre-defined IP addresses
# 3. Allow incoming traffic only on specified ports and from specified IPs

HOSTNAME=$(hostname)

# Clear existing rules
echo "Clearing existing iptables rules..."
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X

# Set default policies (drop everything by default)
echo "Setting default policies..."
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

# Allow loopback interface
echo "Allowing loopback interface..."
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allow established and related connections
echo "Allowing established and related connections..."
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

case "$HOSTNAME" in
"Vault")
  iptables -A INPUT -p tcp --dport 53 -j ACCEPT
  iptables -A INPUT -p tcp --dport 389 -j ACCEPT
  iptables -A INPUT -p tcp --dport 636 -j ACCEPT
  ;;
"Office")
  iptables -A INPUT -p tcp --dport 443 -j ACCEPT
  ;;
"Teller")
  iptables -A INPUT -p tcp --dport 5985 -j ACCEPT
  iptables -A INPUT -p tcp --dport 5986 -j ACCEPT
  ;;
"ATM")
  iptables -A INPUT -p tcp --dport 22 -j ACCEPT
  ;;
"Lobby")
  iptables -A INPUT -p tcp --dport 8006 -j ACCEPT      # Proxmox VE web interface
  iptables -A INPUT -p tcp --dport 3128 -j ACCEPT      # Proxmox proxy
  iptables -A INPUT -p tcp --dport 111 -j ACCEPT       # rpcbind for Proxmox
  iptables -A INPUT -p tcp --dport 5900:5999 -j ACCEPT # VNC for Proxmox VMs
  ;;
"Cashroom")
  iptables -A INPUT -p icmp -j ACCEPT # Allow ICMP (ping)
  ;;
"Lockbox")
  iptables -A INPUT -p tcp --dport 20 -j ACCEPT        # FTP data
  iptables -A INPUT -p tcp --dport 21 -j ACCEPT        # FTP control
  iptables -A INPUT -p tcp --dport 1024:1048 -j ACCEPT # Passive FTP ports
  ;;
"Safe")
  # telnet
  ;;
"Wire")
  # iis
  ;;
"EBanking")
  # http
  ;;
"Accounts")
  iptables -A INPUT -p tcp --dport 3306 -j ACCEPT # MySQL
  ;;
esac

# Allow outgoing traffic to specified IPv4 addresses
echo "Allowing outgoing traffic to IPv4 addresses..."
iptables -A OUTPUT -p tcp -d 107.21.25.247/32 -j ACCEPT   # Allow TCP to 107.21.25.247/32
iptables -A OUTPUT -p udp -d 107.21.25.247/32 -j ACCEPT   # Allow UDP to 107.21.25.247/32
iptables -A OUTPUT -p tcp -d 108.137.133.223/32 -j ACCEPT # Allow TCP to 108.137.133.223/32
iptables -A OUTPUT -p udp -d 108.137.133.223/32 -j ACCEPT # Allow UDP to 108.137.133.223/32
iptables -A OUTPUT -p tcp -d 108.137.188.57/32 -j ACCEPT  # Allow TCP to 108.137.188.57/32
iptables -A OUTPUT -p udp -d 108.137.188.57/32 -j ACCEPT  # Allow UDP to 108.137.188.57/32
iptables -A OUTPUT -p tcp -d 13.114.211.96/32 -j ACCEPT   # Allow TCP to 13.114.211.96/32
iptables -A OUTPUT -p udp -d 13.114.211.96/32 -j ACCEPT   # Allow UDP to 13.114.211.96/32
iptables -A OUTPUT -p tcp -d 13.115.46.213/32 -j ACCEPT   # Allow TCP to 13.115.46.213/32
iptables -A OUTPUT -p udp -d 13.115.46.213/32 -j ACCEPT   # Allow UDP to 13.115.46.213/32
iptables -A OUTPUT -p tcp -d 13.126.169.175/32 -j ACCEPT  # Allow TCP to 13.126.169.175/32
iptables -A OUTPUT -p udp -d 13.126.169.175/32 -j ACCEPT  # Allow UDP to 13.126.169.175/32
iptables -A OUTPUT -p tcp -d 13.208.126.217/32 -j ACCEPT  # Allow TCP to 13.208.126.217/32
iptables -A OUTPUT -p udp -d 13.208.126.217/32 -j ACCEPT  # Allow UDP to 13.208.126.217/32
iptables -A OUTPUT -p tcp -d 13.208.133.55/32 -j ACCEPT   # Allow TCP to 13.208.133.55/32
iptables -A OUTPUT -p udp -d 13.208.133.55/32 -j ACCEPT   # Allow UDP to 13.208.133.55/32
iptables -A OUTPUT -p tcp -d 13.208.142.17/32 -j ACCEPT   # Allow TCP to 13.208.142.17/32
iptables -A OUTPUT -p udp -d 13.208.142.17/32 -j ACCEPT   # Allow UDP to 13.208.142.17/32
iptables -A OUTPUT -p tcp -d 13.208.255.200/32 -j ACCEPT  # Allow TCP to 13.208.255.200/32
iptables -A OUTPUT -p udp -d 13.208.255.200/32 -j ACCEPT  # Allow UDP to 13.208.255.200/32
iptables -A OUTPUT -p tcp -d 13.209.118.42/32 -j ACCEPT   # Allow TCP to 13.209.118.42/32
iptables -A OUTPUT -p udp -d 13.209.118.42/32 -j ACCEPT   # Allow UDP to 13.209.118.42/32
iptables -A OUTPUT -p tcp -d 13.209.230.111/32 -j ACCEPT  # Allow TCP to 13.209.230.111/32
iptables -A OUTPUT -p udp -d 13.209.230.111/32 -j ACCEPT  # Allow UDP to 13.209.230.111/32
iptables -A OUTPUT -p tcp -d 13.234.54.8/32 -j ACCEPT     # Allow TCP to 13.234.54.8/32
iptables -A OUTPUT -p udp -d 13.234.54.8/32 -j ACCEPT     # Allow UDP to 13.234.54.8/32
iptables -A OUTPUT -p tcp -d 13.236.246.161/32 -j ACCEPT  # Allow TCP to 13.236.246.161/32
iptables -A OUTPUT -p udp -d 13.236.246.161/32 -j ACCEPT  # Allow UDP to 13.236.246.161/32
iptables -A OUTPUT -p tcp -d 13.238.14.57/32 -j ACCEPT    # Allow TCP to 13.238.14.57/32
iptables -A OUTPUT -p udp -d 13.238.14.57/32 -j ACCEPT    # Allow UDP to 13.238.14.57/32
iptables -A OUTPUT -p tcp -d 13.244.188.203/32 -j ACCEPT  # Allow TCP to 13.244.188.203/32
iptables -A OUTPUT -p udp -d 13.244.188.203/32 -j ACCEPT  # Allow UDP to 13.244.188.203/32
iptables -A OUTPUT -p tcp -d 13.244.85.86/32 -j ACCEPT    # Allow TCP to 13.244.85.86/32
iptables -A OUTPUT -p udp -d 13.244.85.86/32 -j ACCEPT    # Allow UDP to 13.244.85.86/32
iptables -A OUTPUT -p tcp -d 13.245.194.43/32 -j ACCEPT   # Allow TCP to 13.245.194.43/32
iptables -A OUTPUT -p udp -d 13.245.194.43/32 -j ACCEPT   # Allow UDP to 13.245.194.43/32
iptables -A OUTPUT -p tcp -d 13.245.200.254/32 -j ACCEPT  # Allow TCP to 13.245.200.254/32
iptables -A OUTPUT -p udp -d 13.245.200.254/32 -j ACCEPT  # Allow UDP to 13.245.200.254/32
iptables -A OUTPUT -p tcp -d 13.246.172.210/32 -j ACCEPT  # Allow TCP to 13.246.172.210/32
iptables -A OUTPUT -p udp -d 13.246.172.210/32 -j ACCEPT  # Allow UDP to 13.246.172.210/32
iptables -A OUTPUT -p tcp -d 13.247.164.9/32 -j ACCEPT    # Allow TCP to 13.247.164.9/32
iptables -A OUTPUT -p udp -d 13.247.164.9/32 -j ACCEPT    # Allow UDP to 13.247.164.9/32
iptables -A OUTPUT -p tcp -d 13.48.150.244/32 -j ACCEPT   # Allow TCP to 13.48.150.244/32
iptables -A OUTPUT -p udp -d 13.48.150.244/32 -j ACCEPT   # Allow UDP to 13.48.150.244/32
iptables -A OUTPUT -p tcp -d 13.48.239.118/32 -j ACCEPT   # Allow TCP to 13.48.239.118/32
iptables -A OUTPUT -p udp -d 13.48.239.118/32 -j ACCEPT   # Allow UDP to 13.48.239.118/32
iptables -A OUTPUT -p tcp -d 13.48.254.37/32 -j ACCEPT    # Allow TCP to 13.48.254.37/32
iptables -A OUTPUT -p udp -d 13.48.254.37/32 -j ACCEPT    # Allow UDP to 13.48.254.37/32
iptables -A OUTPUT -p tcp -d 13.54.169.48/32 -j ACCEPT    # Allow TCP to 13.54.169.48/32
iptables -A OUTPUT -p udp -d 13.54.169.48/32 -j ACCEPT    # Allow UDP to 13.54.169.48/32
iptables -A OUTPUT -p tcp -d 15.152.238.192/32 -j ACCEPT  # Allow TCP to 15.152.238.192/32
iptables -A OUTPUT -p udp -d 15.152.238.192/32 -j ACCEPT  # Allow UDP to 15.152.238.192/32
iptables -A OUTPUT -p tcp -d 15.161.86.71/32 -j ACCEPT    # Allow TCP to 15.161.86.71/32
iptables -A OUTPUT -p udp -d 15.161.86.71/32 -j ACCEPT    # Allow UDP to 15.161.86.71/32
iptables -A OUTPUT -p tcp -d 15.165.240.116/32 -j ACCEPT  # Allow TCP to 15.165.240.116/32
iptables -A OUTPUT -p udp -d 15.165.240.116/32 -j ACCEPT  # Allow UDP to 15.165.240.116/32
iptables -A OUTPUT -p tcp -d 15.168.188.85/32 -j ACCEPT   # Allow TCP to 15.168.188.85/32
iptables -A OUTPUT -p udp -d 15.168.188.85/32 -j ACCEPT   # Allow UDP to 15.168.188.85/32
iptables -A OUTPUT -p tcp -d 15.184.139.182/32 -j ACCEPT  # Allow TCP to 15.184.139.182/32
iptables -A OUTPUT -p udp -d 15.184.139.182/32 -j ACCEPT  # Allow UDP to 15.184.139.182/32
iptables -A OUTPUT -p tcp -d 15.185.189.82/32 -j ACCEPT   # Allow TCP to 15.185.189.82/32
iptables -A OUTPUT -p udp -d 15.185.189.82/32 -j ACCEPT   # Allow UDP to 15.185.189.82/32
iptables -A OUTPUT -p tcp -d 15.188.202.64/32 -j ACCEPT   # Allow TCP to 15.188.202.64/32
iptables -A OUTPUT -p udp -d 15.188.202.64/32 -j ACCEPT   # Allow UDP to 15.188.202.64/32
iptables -A OUTPUT -p tcp -d 15.188.240.172/32 -j ACCEPT  # Allow TCP to 15.188.240.172/32
iptables -A OUTPUT -p udp -d 15.188.240.172/32 -j ACCEPT  # Allow UDP to 15.188.240.172/32
iptables -A OUTPUT -p tcp -d 15.188.243.248/32 -j ACCEPT  # Allow TCP to 15.188.243.248/32
iptables -A OUTPUT -p udp -d 15.188.243.248/32 -j ACCEPT  # Allow UDP to 15.188.243.248/32
iptables -A OUTPUT -p tcp -d 157.241.36.106/32 -j ACCEPT  # Allow TCP to 157.241.36.106/32
iptables -A OUTPUT -p udp -d 157.241.36.106/32 -j ACCEPT  # Allow UDP to 157.241.36.106/32
iptables -A OUTPUT -p tcp -d 157.241.93.102/32 -j ACCEPT  # Allow TCP to 157.241.93.102/32
iptables -A OUTPUT -p udp -d 157.241.93.102/32 -j ACCEPT  # Allow UDP to 157.241.93.102/32
iptables -A OUTPUT -p tcp -d 16.162.136.62/32 -j ACCEPT   # Allow TCP to 16.162.136.62/32
iptables -A OUTPUT -p udp -d 16.162.136.62/32 -j ACCEPT   # Allow UDP to 16.162.136.62/32
iptables -A OUTPUT -p tcp -d 16.163.153.45/32 -j ACCEPT   # Allow TCP to 16.163.153.45/32
iptables -A OUTPUT -p udp -d 16.163.153.45/32 -j ACCEPT   # Allow UDP to 16.163.153.45/32
iptables -A OUTPUT -p tcp -d 16.24.38.13/32 -j ACCEPT     # Allow TCP to 16.24.38.13/32
iptables -A OUTPUT -p udp -d 16.24.38.13/32 -j ACCEPT     # Allow UDP to 16.24.38.13/32
iptables -A OUTPUT -p tcp -d 16.24.60.114/32 -j ACCEPT    # Allow TCP to 16.24.60.114/32
iptables -A OUTPUT -p udp -d 16.24.60.114/32 -j ACCEPT    # Allow UDP to 16.24.60.114/32
iptables -A OUTPUT -p tcp -d 18.102.80.189/32 -j ACCEPT   # Allow TCP to 18.102.80.189/32
iptables -A OUTPUT -p udp -d 18.102.80.189/32 -j ACCEPT   # Allow UDP to 18.102.80.189/32
iptables -A OUTPUT -p tcp -d 18.130.113.168/32 -j ACCEPT  # Allow TCP to 18.130.113.168/32
iptables -A OUTPUT -p udp -d 18.130.113.168/32 -j ACCEPT  # Allow UDP to 18.130.113.168/32
iptables -A OUTPUT -p tcp -d 18.139.52.173/32 -j ACCEPT   # Allow TCP to 18.139.52.173/32
iptables -A OUTPUT -p udp -d 18.139.52.173/32 -j ACCEPT   # Allow UDP to 18.139.52.173/32
iptables -A OUTPUT -p tcp -d 18.163.21.55/32 -j ACCEPT    # Allow TCP to 18.163.21.55/32
iptables -A OUTPUT -p udp -d 18.163.21.55/32 -j ACCEPT    # Allow UDP to 18.163.21.55/32
iptables -A OUTPUT -p tcp -d 18.163.59.106/32 -j ACCEPT   # Allow TCP to 18.163.59.106/32
iptables -A OUTPUT -p udp -d 18.163.59.106/32 -j ACCEPT   # Allow UDP to 18.163.59.106/32
iptables -A OUTPUT -p tcp -d 18.166.19.255/32 -j ACCEPT   # Allow TCP to 18.166.19.255/32
iptables -A OUTPUT -p udp -d 18.166.19.255/32 -j ACCEPT   # Allow UDP to 18.166.19.255/32
iptables -A OUTPUT -p tcp -d 18.195.155.52/32 -j ACCEPT   # Allow TCP to 18.195.155.52/32
iptables -A OUTPUT -p udp -d 18.195.155.52/32 -j ACCEPT   # Allow UDP to 18.195.155.52/32
iptables -A OUTPUT -p tcp -d 18.200.120.237/32 -j ACCEPT  # Allow TCP to 18.200.120.237/32
iptables -A OUTPUT -p udp -d 18.200.120.237/32 -j ACCEPT  # Allow UDP to 18.200.120.237/32
iptables -A OUTPUT -p tcp -d 18.229.28.50/32 -j ACCEPT    # Allow TCP to 18.229.28.50/32
iptables -A OUTPUT -p udp -d 18.229.28.50/32 -j ACCEPT    # Allow UDP to 18.229.28.50/32
iptables -A OUTPUT -p tcp -d 18.229.36.120/32 -j ACCEPT   # Allow TCP to 18.229.36.120/32
iptables -A OUTPUT -p udp -d 18.229.36.120/32 -j ACCEPT   # Allow UDP to 18.229.36.120/32
iptables -A OUTPUT -p tcp -d 20.62.248.141/32 -j ACCEPT   # Allow TCP to 20.62.248.141/32
iptables -A OUTPUT -p udp -d 20.62.248.141/32 -j ACCEPT   # Allow UDP to 20.62.248.141/32
iptables -A OUTPUT -p tcp -d 20.83.144.189/32 -j ACCEPT   # Allow TCP to 20.83.144.189/32
iptables -A OUTPUT -p udp -d 20.83.144.189/32 -j ACCEPT   # Allow UDP to 20.83.144.189/32
iptables -A OUTPUT -p tcp -d 209.162.159.0/26 -j ACCEPT   # Allow TCP to 209.162.159.0/26
iptables -A OUTPUT -p udp -d 209.162.159.0/26 -j ACCEPT   # Allow UDP to 209.162.159.0/26
iptables -A OUTPUT -p tcp -d 3.120.223.25/32 -j ACCEPT    # Allow TCP to 3.120.223.25/32
iptables -A OUTPUT -p udp -d 3.120.223.25/32 -j ACCEPT    # Allow UDP to 3.120.223.25/32
iptables -A OUTPUT -p tcp -d 3.121.24.234/32 -j ACCEPT    # Allow TCP to 3.121.24.234/32
iptables -A OUTPUT -p udp -d 3.121.24.234/32 -j ACCEPT    # Allow UDP to 3.121.24.234/32
iptables -A OUTPUT -p tcp -d 3.1.219.207/32 -j ACCEPT     # Allow TCP to 3.1.219.207/32
iptables -A OUTPUT -p udp -d 3.1.219.207/32 -j ACCEPT     # Allow UDP to 3.1.219.207/32
iptables -A OUTPUT -p tcp -d 3.1.36.99/32 -j ACCEPT       # Allow TCP to 3.1.36.99/32
iptables -A OUTPUT -p udp -d 3.1.36.99/32 -j ACCEPT       # Allow UDP to 3.1.36.99/32
iptables -A OUTPUT -p tcp -d 3.18.172.189/32 -j ACCEPT    # Allow TCP to 3.18.172.189/32
iptables -A OUTPUT -p udp -d 3.18.172.189/32 -j ACCEPT    # Allow UDP to 3.18.172.189/32
iptables -A OUTPUT -p tcp -d 3.18.188.104/32 -j ACCEPT    # Allow TCP to 3.18.188.104/32
iptables -A OUTPUT -p udp -d 3.18.188.104/32 -j ACCEPT    # Allow UDP to 3.18.188.104/32
iptables -A OUTPUT -p tcp -d 3.18.197.0/32 -j ACCEPT      # Allow TCP to 3.18.197.0/32
iptables -A OUTPUT -p udp -d 3.18.197.0/32 -j ACCEPT      # Allow UDP to 3.18.197.0/32
iptables -A OUTPUT -p tcp -d 3.35.66.96/32 -j ACCEPT      # Allow TCP to 3.35.66.96/32
iptables -A OUTPUT -p udp -d 3.35.66.96/32 -j ACCEPT      # Allow UDP to 3.35.66.96/32
iptables -A OUTPUT -p tcp -d 3.36.177.119/32 -j ACCEPT    # Allow TCP to 3.36.177.119/32
iptables -A OUTPUT -p udp -d 3.36.177.119/32 -j ACCEPT    # Allow UDP to 3.36.177.119/32
iptables -A OUTPUT -p tcp -d 34.0.225.0/24 -j ACCEPT      # Allow TCP to 34.0.225.0/24
iptables -A OUTPUT -p udp -d 34.0.225.0/24 -j ACCEPT      # Allow UDP to 34.0.225.0/24
iptables -A OUTPUT -p tcp -d 34.110.187.75/32 -j ACCEPT   # Allow TCP to 34.110.187.75/32
iptables -A OUTPUT -p udp -d 34.110.187.75/32 -j ACCEPT   # Allow UDP to 34.110.187.75/32
iptables -A OUTPUT -p tcp -d 34.117.129.254/32 -j ACCEPT  # Allow TCP to 34.117.129.254/32
iptables -A OUTPUT -p udp -d 34.117.129.254/32 -j ACCEPT  # Allow UDP to 34.117.129.254/32
iptables -A OUTPUT -p tcp -d 34.145.82.128/29 -j ACCEPT   # Allow TCP to 34.145.82.128/29
iptables -A OUTPUT -p udp -d 34.145.82.128/29 -j ACCEPT   # Allow UDP to 34.145.82.128/29
iptables -A OUTPUT -p tcp -d 34.146.154.144/29 -j ACCEPT  # Allow TCP to 34.146.154.144/29
iptables -A OUTPUT -p udp -d 34.146.154.144/29 -j ACCEPT  # Allow UDP to 34.146.154.144/29
iptables -A OUTPUT -p tcp -d 34.149.119.85/32 -j ACCEPT   # Allow TCP to 34.149.119.85/32
iptables -A OUTPUT -p udp -d 34.149.119.85/32 -j ACCEPT   # Allow UDP to 34.149.119.85/32
iptables -A OUTPUT -p tcp -d 34.149.203.90/32 -j ACCEPT   # Allow TCP to 34.149.203.90/32
iptables -A OUTPUT -p udp -d 34.149.203.90/32 -j ACCEPT   # Allow UDP to 34.149.203.90/32
iptables -A OUTPUT -p tcp -d 34.149.54.227/32 -j ACCEPT   # Allow TCP to 34.149.54.227/32
iptables -A OUTPUT -p udp -d 34.149.54.227/32 -j ACCEPT   # Allow UDP to 34.149.54.227/32
iptables -A OUTPUT -p tcp -d 34.149.66.128/26 -j ACCEPT   # Allow TCP to 34.149.66.128/26
iptables -A OUTPUT -p udp -d 34.149.66.128/26 -j ACCEPT   # Allow UDP to 34.149.66.128/26
iptables -A OUTPUT -p tcp -d 34.149.66.131/32 -j ACCEPT   # Allow TCP to 34.149.66.131/32
iptables -A OUTPUT -p udp -d 34.149.66.131/32 -j ACCEPT   # Allow UDP to 34.149.66.131/32
iptables -A OUTPUT -p tcp -d 34.159.50.128/29 -j ACCEPT   # Allow TCP to 34.159.50.128/29
iptables -A OUTPUT -p udp -d 34.159.50.128/29 -j ACCEPT   # Allow UDP to 34.159.50.128/29
iptables -A OUTPUT -p tcp -d 34.160.125.158/32 -j ACCEPT  # Allow TCP to 34.160.125.158/32
iptables -A OUTPUT -p udp -d 34.160.125.158/32 -j ACCEPT  # Allow UDP to 34.160.125.158/32
iptables -A OUTPUT -p tcp -d 34.160.150.109/32 -j ACCEPT  # Allow TCP to 34.160.150.109/32
iptables -A OUTPUT -p udp -d 34.160.150.109/32 -j ACCEPT  # Allow UDP to 34.160.150.109/32
iptables -A OUTPUT -p tcp -d 34.160.40.115/32 -j ACCEPT   # Allow TCP to 34.160.40.115/32
iptables -A OUTPUT -p udp -d 34.160.40.115/32 -j ACCEPT   # Allow UDP to 34.160.40.115/32
iptables -A OUTPUT -p tcp -d 34.160.41.148/32 -j ACCEPT   # Allow TCP to 34.160.41.148/32
iptables -A OUTPUT -p udp -d 34.160.41.148/32 -j ACCEPT   # Allow UDP to 34.160.41.148/32
iptables -A OUTPUT -p tcp -d 34.160.7.29/32 -j ACCEPT     # Allow TCP to 34.160.7.29/32
iptables -A OUTPUT -p udp -d 34.160.7.29/32 -j ACCEPT     # Allow UDP to 34.160.7.29/32
iptables -A OUTPUT -p tcp -d 34.174.98.16/29 -j ACCEPT    # Allow TCP to 34.174.98.16/29
iptables -A OUTPUT -p udp -d 34.174.98.16/29 -j ACCEPT    # Allow UDP to 34.174.98.16/29
iptables -A OUTPUT -p tcp -d 34.208.32.189/32 -j ACCEPT   # Allow TCP to 34.208.32.189/32
iptables -A OUTPUT -p udp -d 34.208.32.189/32 -j ACCEPT   # Allow UDP to 34.208.32.189/32
iptables -A OUTPUT -p tcp -d 34.48.76.208/29 -j ACCEPT    # Allow TCP to 34.48.76.208/29
iptables -A OUTPUT -p udp -d 34.48.76.208/29 -j ACCEPT    # Allow UDP to 34.48.76.208/29
iptables -A OUTPUT -p tcp -d 34.69.237.0/24 -j ACCEPT     # Allow TCP to 34.69.237.0/24
iptables -A OUTPUT -p udp -d 34.69.237.0/24 -j ACCEPT     # Allow UDP to 34.69.237.0/24
iptables -A OUTPUT -p tcp -d 34.94.234.88/29 -j ACCEPT    # Allow TCP to 34.94.234.88/29
iptables -A OUTPUT -p udp -d 34.94.234.88/29 -j ACCEPT    # Allow UDP to 34.94.234.88/29
iptables -A OUTPUT -p tcp -d 35.152.76.8/32 -j ACCEPT     # Allow TCP to 35.152.76.8/32
iptables -A OUTPUT -p udp -d 35.152.76.8/32 -j ACCEPT     # Allow UDP to 35.152.76.8/32
iptables -A OUTPUT -p tcp -d 35.154.93.182/32 -j ACCEPT   # Allow TCP to 35.154.93.182/32
iptables -A OUTPUT -p udp -d 35.154.93.182/32 -j ACCEPT   # Allow UDP to 35.154.93.182/32
iptables -A OUTPUT -p tcp -d 35.176.195.46/32 -j ACCEPT   # Allow TCP to 35.176.195.46/32
iptables -A OUTPUT -p udp -d 35.176.195.46/32 -j ACCEPT   # Allow UDP to 35.176.195.46/32
iptables -A OUTPUT -p tcp -d 35.177.43.250/32 -j ACCEPT   # Allow TCP to 35.177.43.250/32
iptables -A OUTPUT -p udp -d 35.177.43.250/32 -j ACCEPT   # Allow UDP to 35.177.43.250/32
iptables -A OUTPUT -p tcp -d 35.190.51.116/32 -j ACCEPT   # Allow TCP to 35.190.51.116/32
iptables -A OUTPUT -p udp -d 35.190.51.116/32 -j ACCEPT   # Allow UDP to 35.190.51.116/32
iptables -A OUTPUT -p tcp -d 35.244.255.175/32 -j ACCEPT  # Allow TCP to 35.244.255.175/32
iptables -A OUTPUT -p udp -d 35.244.255.175/32 -j ACCEPT  # Allow UDP to 35.244.255.175/32
iptables -A OUTPUT -p tcp -d 3.92.150.182/32 -j ACCEPT    # Allow TCP to 3.92.150.182/32
iptables -A OUTPUT -p udp -d 3.92.150.182/32 -j ACCEPT    # Allow UDP to 3.92.150.182/32
iptables -A OUTPUT -p tcp -d 3.96.7.126/32 -j ACCEPT      # Allow TCP to 3.96.7.126/32
iptables -A OUTPUT -p udp -d 3.96.7.126/32 -j ACCEPT      # Allow UDP to 3.96.7.126/32
iptables -A OUTPUT -p tcp -d 40.76.107.170/32 -j ACCEPT   # Allow TCP to 40.76.107.170/32
iptables -A OUTPUT -p udp -d 40.76.107.170/32 -j ACCEPT   # Allow UDP to 40.76.107.170/32
iptables -A OUTPUT -p tcp -d 43.198.123.228/32 -j ACCEPT  # Allow TCP to 43.198.123.228/32
iptables -A OUTPUT -p udp -d 43.198.123.228/32 -j ACCEPT  # Allow UDP to 43.198.123.228/32
iptables -A OUTPUT -p tcp -d 43.203.72.233/32 -j ACCEPT   # Allow TCP to 43.203.72.233/32
iptables -A OUTPUT -p udp -d 43.203.72.233/32 -j ACCEPT   # Allow UDP to 43.203.72.233/32
iptables -A OUTPUT -p tcp -d 43.218.5.202/32 -j ACCEPT    # Allow TCP to 43.218.5.202/32
iptables -A OUTPUT -p udp -d 43.218.5.202/32 -j ACCEPT    # Allow UDP to 43.218.5.202/32
iptables -A OUTPUT -p tcp -d 52.192.175.207/32 -j ACCEPT  # Allow TCP to 52.192.175.207/32
iptables -A OUTPUT -p udp -d 52.192.175.207/32 -j ACCEPT  # Allow UDP to 52.192.175.207/32
iptables -A OUTPUT -p tcp -d 52.35.61.232/32 -j ACCEPT    # Allow TCP to 52.35.61.232/32
iptables -A OUTPUT -p udp -d 52.35.61.232/32 -j ACCEPT    # Allow UDP to 52.35.61.232/32
iptables -A OUTPUT -p tcp -d 52.55.56.26/32 -j ACCEPT     # Allow TCP to 52.55.56.26/32
iptables -A OUTPUT -p udp -d 52.55.56.26/32 -j ACCEPT     # Allow UDP to 52.55.56.26/32
iptables -A OUTPUT -p tcp -d 52.60.189.53/32 -j ACCEPT    # Allow TCP to 52.60.189.53/32
iptables -A OUTPUT -p udp -d 52.60.189.53/32 -j ACCEPT    # Allow UDP to 52.60.189.53/32
iptables -A OUTPUT -p tcp -d 52.67.95.251/32 -j ACCEPT    # Allow TCP to 52.67.95.251/32
iptables -A OUTPUT -p udp -d 52.67.95.251/32 -j ACCEPT    # Allow UDP to 52.67.95.251/32
iptables -A OUTPUT -p tcp -d 52.89.221.151/32 -j ACCEPT   # Allow TCP to 52.89.221.151/32
iptables -A OUTPUT -p udp -d 52.89.221.151/32 -j ACCEPT   # Allow UDP to 52.89.221.151/32
iptables -A OUTPUT -p tcp -d 52.9.13.199/32 -j ACCEPT     # Allow TCP to 52.9.13.199/32
iptables -A OUTPUT -p udp -d 52.9.13.199/32 -j ACCEPT     # Allow UDP to 52.9.13.199/32
iptables -A OUTPUT -p tcp -d 52.9.139.134/32 -j ACCEPT    # Allow TCP to 52.9.139.134/32
iptables -A OUTPUT -p udp -d 52.9.139.134/32 -j ACCEPT    # Allow UDP to 52.9.139.134/32
iptables -A OUTPUT -p tcp -d 54.177.155.33/32 -j ACCEPT   # Allow TCP to 54.177.155.33/32
iptables -A OUTPUT -p udp -d 54.177.155.33/32 -j ACCEPT   # Allow UDP to 54.177.155.33/32
iptables -A OUTPUT -p tcp -d 63.34.100.178/32 -j ACCEPT   # Allow TCP to 63.34.100.178/32
iptables -A OUTPUT -p udp -d 63.34.100.178/32 -j ACCEPT   # Allow UDP to 63.34.100.178/32
iptables -A OUTPUT -p tcp -d 63.35.33.198/32 -j ACCEPT    # Allow TCP to 63.35.33.198/32
iptables -A OUTPUT -p udp -d 63.35.33.198/32 -j ACCEPT    # Allow UDP to 63.35.33.198/32
iptables -A OUTPUT -p tcp -d 99.79.87.237/32 -j ACCEPT    # Allow TCP to 99.79.87.237/32
iptables -A OUTPUT -p udp -d 99.79.87.237/32 -j ACCEPT    # Allow UDP to 99.79.87.237/32

# Configure IPv6 firewall rules
if command -v ip6tables &>/dev/null; then
  echo "Configuring IPv6 firewall rules..."

  # Clear existing IPv6 rules
  ip6tables -F
  ip6tables -X
  ip6tables -t mangle -F
  ip6tables -t mangle -X

  # Set default IPv6 policies
  ip6tables -P INPUT DROP
  ip6tables -P FORWARD DROP
  ip6tables -P OUTPUT DROP

  # Allow loopback interface
  ip6tables -A INPUT -i lo -j ACCEPT
  ip6tables -A OUTPUT -o lo -j ACCEPT

  # Allow established and related connections
  ip6tables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
  ip6tables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

  # Allow ICMPv6 for proper IPv6 functioning
  ip6tables -A INPUT -p ipv6-icmp -j ACCEPT
  ip6tables -A OUTPUT -p ipv6-icmp -j ACCEPT

  # Allow outgoing traffic to specified IPv6 addresses
  echo "Allowing outgoing traffic to IPv6 addresses..."
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:1db4::/128 -j ACCEPT # Allow TCP to 2600:1901:0:1db4::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:1db4::/128 -j ACCEPT # Allow UDP to 2600:1901:0:1db4::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:24d::/128 -j ACCEPT  # Allow TCP to 2600:1901:0:24d::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:24d::/128 -j ACCEPT  # Allow UDP to 2600:1901:0:24d::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:3084::/128 -j ACCEPT # Allow TCP to 2600:1901:0:3084::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:3084::/128 -j ACCEPT # Allow UDP to 2600:1901:0:3084::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:3af5::/128 -j ACCEPT # Allow TCP to 2600:1901:0:3af5::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:3af5::/128 -j ACCEPT # Allow UDP to 2600:1901:0:3af5::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:3ff3::/128 -j ACCEPT # Allow TCP to 2600:1901:0:3ff3::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:3ff3::/128 -j ACCEPT # Allow UDP to 2600:1901:0:3ff3::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:44f4::/128 -j ACCEPT # Allow TCP to 2600:1901:0:44f4::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:44f4::/128 -j ACCEPT # Allow UDP to 2600:1901:0:44f4::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:4612::/128 -j ACCEPT # Allow TCP to 2600:1901:0:4612::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:4612::/128 -j ACCEPT # Allow UDP to 2600:1901:0:4612::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:4693::/128 -j ACCEPT # Allow TCP to 2600:1901:0:4693::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:4693::/128 -j ACCEPT # Allow UDP to 2600:1901:0:4693::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:48bd::/128 -j ACCEPT # Allow TCP to 2600:1901:0:48bd::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:48bd::/128 -j ACCEPT # Allow UDP to 2600:1901:0:48bd::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:4cce::/128 -j ACCEPT # Allow TCP to 2600:1901:0:4cce::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:4cce::/128 -j ACCEPT # Allow UDP to 2600:1901:0:4cce::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:51ba::/128 -j ACCEPT # Allow TCP to 2600:1901:0:51ba::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:51ba::/128 -j ACCEPT # Allow UDP to 2600:1901:0:51ba::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:5732::/128 -j ACCEPT # Allow TCP to 2600:1901:0:5732::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:5732::/128 -j ACCEPT # Allow UDP to 2600:1901:0:5732::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:5873::/128 -j ACCEPT # Allow TCP to 2600:1901:0:5873::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:5873::/128 -j ACCEPT # Allow UDP to 2600:1901:0:5873::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:5a37::/128 -j ACCEPT # Allow TCP to 2600:1901:0:5a37::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:5a37::/128 -j ACCEPT # Allow UDP to 2600:1901:0:5a37::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:5a5a::/128 -j ACCEPT # Allow TCP to 2600:1901:0:5a5a::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:5a5a::/128 -j ACCEPT # Allow UDP to 2600:1901:0:5a5a::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:635b::/128 -j ACCEPT # Allow TCP to 2600:1901:0:635b::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:635b::/128 -j ACCEPT # Allow UDP to 2600:1901:0:635b::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:658::/128 -j ACCEPT  # Allow TCP to 2600:1901:0:658::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:658::/128 -j ACCEPT  # Allow UDP to 2600:1901:0:658::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:6dd::/128 -j ACCEPT  # Allow TCP to 2600:1901:0:6dd::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:6dd::/128 -j ACCEPT  # Allow UDP to 2600:1901:0:6dd::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:7576::/128 -j ACCEPT # Allow TCP to 2600:1901:0:7576::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:7576::/128 -j ACCEPT # Allow UDP to 2600:1901:0:7576::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:778c::/128 -j ACCEPT # Allow TCP to 2600:1901:0:778c::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:778c::/128 -j ACCEPT # Allow UDP to 2600:1901:0:778c::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:79f3::/128 -j ACCEPT # Allow TCP to 2600:1901:0:79f3::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:79f3::/128 -j ACCEPT # Allow UDP to 2600:1901:0:79f3::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:8284::/128 -j ACCEPT # Allow TCP to 2600:1901:0:8284::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:8284::/128 -j ACCEPT # Allow UDP to 2600:1901:0:8284::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:8a8e::/128 -j ACCEPT # Allow TCP to 2600:1901:0:8a8e::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:8a8e::/128 -j ACCEPT # Allow UDP to 2600:1901:0:8a8e::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:9f47::/128 -j ACCEPT # Allow TCP to 2600:1901:0:9f47::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:9f47::/128 -j ACCEPT # Allow UDP to 2600:1901:0:9f47::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:a3f5::/128 -j ACCEPT # Allow TCP to 2600:1901:0:a3f5::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:a3f5::/128 -j ACCEPT # Allow UDP to 2600:1901:0:a3f5::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:a954::/128 -j ACCEPT # Allow TCP to 2600:1901:0:a954::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:a954::/128 -j ACCEPT # Allow UDP to 2600:1901:0:a954::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:ab44::/128 -j ACCEPT # Allow TCP to 2600:1901:0:ab44::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:ab44::/128 -j ACCEPT # Allow UDP to 2600:1901:0:ab44::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:b2ad::/128 -j ACCEPT # Allow TCP to 2600:1901:0:b2ad::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:b2ad::/128 -j ACCEPT # Allow UDP to 2600:1901:0:b2ad::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:b312::/128 -j ACCEPT # Allow TCP to 2600:1901:0:b312::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:b312::/128 -j ACCEPT # Allow UDP to 2600:1901:0:b312::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:b7a3::/128 -j ACCEPT # Allow TCP to 2600:1901:0:b7a3::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:b7a3::/128 -j ACCEPT # Allow UDP to 2600:1901:0:b7a3::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:c6b2::/128 -j ACCEPT # Allow TCP to 2600:1901:0:c6b2::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:c6b2::/128 -j ACCEPT # Allow UDP to 2600:1901:0:c6b2::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:c7b8::/128 -j ACCEPT # Allow TCP to 2600:1901:0:c7b8::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:c7b8::/128 -j ACCEPT # Allow UDP to 2600:1901:0:c7b8::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:c8f7::/128 -j ACCEPT # Allow TCP to 2600:1901:0:c8f7::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:c8f7::/128 -j ACCEPT # Allow UDP to 2600:1901:0:c8f7::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:d061::/128 -j ACCEPT # Allow TCP to 2600:1901:0:d061::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:d061::/128 -j ACCEPT # Allow UDP to 2600:1901:0:d061::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:d24e::/128 -j ACCEPT # Allow TCP to 2600:1901:0:d24e::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:d24e::/128 -j ACCEPT # Allow UDP to 2600:1901:0:d24e::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:d3e7::/128 -j ACCEPT # Allow TCP to 2600:1901:0:d3e7::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:d3e7::/128 -j ACCEPT # Allow UDP to 2600:1901:0:d3e7::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:d8fd::/128 -j ACCEPT # Allow TCP to 2600:1901:0:d8fd::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:d8fd::/128 -j ACCEPT # Allow UDP to 2600:1901:0:d8fd::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:dcf0::/128 -j ACCEPT # Allow TCP to 2600:1901:0:dcf0::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:dcf0::/128 -j ACCEPT # Allow UDP to 2600:1901:0:dcf0::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:df08::/128 -j ACCEPT # Allow TCP to 2600:1901:0:df08::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:df08::/128 -j ACCEPT # Allow UDP to 2600:1901:0:df08::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:e402::/128 -j ACCEPT # Allow TCP to 2600:1901:0:e402::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:e402::/128 -j ACCEPT # Allow UDP to 2600:1901:0:e402::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:e7bf::/128 -j ACCEPT # Allow TCP to 2600:1901:0:e7bf::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:e7bf::/128 -j ACCEPT # Allow UDP to 2600:1901:0:e7bf::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:f8cd::/128 -j ACCEPT # Allow TCP to 2600:1901:0:f8cd::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:f8cd::/128 -j ACCEPT # Allow UDP to 2600:1901:0:f8cd::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:fd32::/128 -j ACCEPT # Allow TCP to 2600:1901:0:fd32::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:fd32::/128 -j ACCEPT # Allow UDP to 2600:1901:0:fd32::/128
  ip6tables -A OUTPUT -p tcp -d 2600:1901:0:ffbc::/128 -j ACCEPT # Allow TCP to 2600:1901:0:ffbc::/128
  ip6tables -A OUTPUT -p udp -d 2600:1901:0:ffbc::/128 -j ACCEPT # Allow UDP to 2600:1901:0:ffbc::/128

  mkdir -p /etc/iptables/

  # Save IPv6 rules
  if command -v ip6tables-save >/dev/null 2>&1; then
    ip6tables-save >/etc/iptables/rules.v6
    echo "IPv6 rules saved to /etc/iptables/rules.v6"
  elif [ -d "/etc/sysconfig" ]; then
    ip6tables-save >/etc/sysconfig/ip6tables
    echo "IPv6 rules saved to /etc/sysconfig/ip6tables"
  else
    echo "WARNING: Could not save ip6tables rules permanently. Please save them manually."
    ip6tables-save
  fi
else
  echo "IPv6 support not detected, skipping IPv6 configuration"
fi

# Allow DNS resolution (optional, but usually necessary)
echo "Allowing DNS resolution..."
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT

# Save the rules
echo "Saving iptables rules..."
if command -v iptables-save >/dev/null 2>&1; then
  iptables-save >/etc/iptables/rules.v4
  echo "Rules saved to /etc/iptables/rules.v4"
elif [ -d "/etc/sysconfig" ]; then
  # Red Hat-based systems
  iptables-save >/etc/sysconfig/iptables
  echo "Rules saved to /etc/sysconfig/iptables"
else
  echo "WARNING: Could not save iptables rules permanently. Please save them manually."
  iptables-save
fi

echo "Firewall configuration complete."
