#!/bin/bash

sudo systemctl stop ssh
sudo apt-get remove --purge openssh-server openssh-client
sudo rm -rf /etc/ssh
sudo rm -rf /home/*/.ssh

echo "ssh purged, reinstalling now..."

sudo apt install -y openssh-client
sudo apt install -y openssh-server

sudo systemctl enable ssh
sudo systemctl start ssh

