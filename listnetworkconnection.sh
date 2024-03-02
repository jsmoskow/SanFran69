#!/bin/bash

for connection in $(lsof -i | awk '); do
    $1 == "COMMAND" || $1 == "tcp" || $1 == "udp" {
        if ($1 == "COMMAND") {
            printf "%-20s %-10s %-25s %s\n", "Process Name", "PID", "Connection Address", "User"
            printf "%-20s %-10s %-25s %s\n", "------------", "---", "------------------", "----"
        } else {
            printf "%-20s %-10s %-25s %s\n", $1, $2, $9, $3
        }
    }
'
