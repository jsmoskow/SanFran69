#!/bin/bash

expectedhash=8c20cd717552790f2312db0981337945

sudoershash=$(md5sum /etc/sudoers | awk '{print $1}')

if [ "$sudoershash" = "$expectedhash" ]; then
    echo "sudoers is unchanged from default"
else
    echo "RIT is cringe and edited /etc/sudoers, check the file"
fi
