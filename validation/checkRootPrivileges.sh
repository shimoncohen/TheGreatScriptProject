#!/bin/bash

# From: https://stackoverflow.com/questions/18215973/how-to-check-if-running-as-root-in-a-bash-script
# Check if script is running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

exit 0
