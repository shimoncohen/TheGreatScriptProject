#!/bin/bash

DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Install command
bash ${DIRECTORY%/*}/../validation/installCommandIfNotPresent.sh redis-server
