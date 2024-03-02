#!/bin/bash

connection=$(lsof -i | awk '{print $1, $2, $3, $9}' | sort | uniq)

echo $connection
