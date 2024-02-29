#!/bin/bash

expectedhash=5bac27ce5ff1a78ace8f3ef3ef81bfd60cbd44810ac3f3d280da9d7649fe90c18f8

sudoershash=$(sha256sum /etc/sudoers | awk '{print $1}')

if [ "$sudoershash" = "$expectedhash" ]; then
    echo "sudoers is unchanged from default"
else
    echo "RIT is cringe and edited /etc/sudoers, check the file"
fi
