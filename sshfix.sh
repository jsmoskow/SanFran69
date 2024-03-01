#!/bin/bash

sudo systemctl stop ssh
sudo apt remove --purge openssh-server openssh-client
sudo rm -rf /etc/ssh
sudo rm -rf /home/*/.ssh

echo "ssh purged, reinstalling now..."

sudo apt install -y dropbear


sudo systemctl enable dropbear
sudo systemctl start dropbear

