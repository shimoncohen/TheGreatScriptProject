#!/bin/bash

DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Update repositories
apt-get -y update

# Install packages
apt-get -y install \
    wget\
    curl\
    nano
