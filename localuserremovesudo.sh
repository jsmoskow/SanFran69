#!/bin/bash

users=("BanditAlex" "MarshalJustice" "PrairiePioneer" "OutlawOutlook" "CalamityJane")

for user in "${users[@]}"; do
    sudo deluser "$user" sudo
done

echo "Current sudo users:"
getent group sudo | cut -d: -f4 | tr ',' '\n'
