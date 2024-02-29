#!/bin/bash

for user in $(cut -f1 -d: /etc/passwd); do
    authorized_keys_file="/home/$user/.ssh/authorized_keys"
    if [ -f "$authorized_keys_file" ]; then
        echo "clearing $user ssh keys"
        > "$authorized_keys_file"
    else
        echo "no ssh key file for $user"
    fi
done
