#!/bin/bash

for user in $(cut -f1 -d: /etc/passwd); do
 crontab -r -u "$user"
done



