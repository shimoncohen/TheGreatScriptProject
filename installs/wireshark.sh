#!/bin/bash

DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Add wireshark repository
bash ${DIRECTORY%/*}/../validation/addRepositoryIfNotPresent.sh ppa:wireshark-dev/stable

# Update packages
apt-get -y update

# Install wireshark
apt-get -y install wireshark

# To allow non-root users to capture:
# Select yes when asked
chmod +x /usr/bin/dumpcap

# If didn't select yes when asked run:
# dpkg-reconfigure wireshark-common # Select yes when asked