#!/bin/bash

for user in $(grep '^[^:]*:[^\*!]' /etc/shadow | cut -f1 -d:); do 
    echo "$user:kirkcharlie" | chpasswd
done
