#!/bin/bash

DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Check if command is already installed
bash ${DIRECTORY%/*}/../../validation/checkIfCommandExists.sh helm
test $? -eq 1 || exit

# Install snap
bash ${DIRECTORY%/*}/../snap/snap.sh

# Install helm
snap install helm --classic