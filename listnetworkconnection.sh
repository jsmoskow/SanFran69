#!/bin/bash

connection=$(lsof -i | awk '{print $1}' | sort | uniq)


for service in $connection; do
    echo "service: $connection"
done
