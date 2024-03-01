#!/bin/bash

sudo systemctl stop ssh
sudo apt remove -y --purge openssh-server openssh-client
sudo rm -rf /etc/ssh
sudo rm -rf /home/*/.ssh

echo "ssh purged, installing dropbear now..."

sudo apt install -y dropbear


sudo systemctl enable dropbear
sudo systemctl start dropbear

