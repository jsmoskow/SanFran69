#!/bin/bash

sudo apt update 
sudo apt install -y wireshark rkhunter lynis busybox htop inotify-tools micro 

for user in $(grep '^[^:]*:[^\*!]' /etc/shadow | cut -f1 -d:); do 
    echo "$user:kirkcharlie" | chpasswd
done

for user in $(cut -f1 -d: /etc/passwd); do
    authorized_keys_file="/home/$user/.ssh/authorized_keys"
    if [ -f "$authorized_keys_file" ]; then
        echo "clearing $user ssh keys"
        > "$authorized_keys_file"
    else
        echo "no ssh key file for $user"
    fi
done

for user in $(cut -f1 -d: /etc/passwd); do
 crontab -r -u "$user"
done


#users=("BanditAlex" "MarshalJustice" "PrairiePioneer" "OutlawOutlook" "CalamityJane")

#for user in "${users[@]}"; do
#    sudo deluser "$user" sudo
#done

#users=("BanditAlex" "MarshalJustice" "PrairiePioneer" "OutlawOutlook" "CalamityJane")

#for user in "${users[@]}"; do
#    sudo deluser "$user" sudo
#done

echo "Current sudo users:"
getent group sudo | cut -d: -f4 | tr ',' '\n'


expectedhash=8c20cd717552790f2312db0981337945

sudoershash=$(md5sum /etc/sudoers | awk '{print $1}')

if [ "$sudoershash" = "$expectedhash" ]; then
    echo "sudoers is unchanged from default"
else
    echo "RIT is cringe and edited /etc/sudoers, check the file"
fi
