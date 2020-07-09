#!/bin/bash

DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Check if command exists
bash ${DIRECTORY%/*}/../validation/checkIfCommandExists.sh yarn
test $? -eq 0 && exit

# Add yarn repository
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Update packages
apt-get update -y

# Install dependencies
apt-get -y install --no-install-recommends yarn
