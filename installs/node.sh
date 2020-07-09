#!/bin/bash

DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

VERSION=14

function usage {
    echo "Run node.sh to install default version 14"
    echo "Run node.sh --version <wanted_version> to install a different version"
}

# Loop through arguments and process them
# Taken from: https://pretzelhands.com/posts/command-line-flags
for arg in "$@"
do
    case $arg in
        --help)
        usage
        shift # Remove --help
        exit
        ;;
        --version=*)
        VERSION="${arg#*=}"
        shift # Remove
        ;;
        --version)
        VERSION="$2"
        shift # Remove
        shift
        ;;
    esac
done

# Check if command is already installed
bash ${DIRECTORY%/*}/../../validation/checkIfCommandExists.sh nodejs
test $? -eq 1 || exit

# Add node repository
curl -sL https://deb.nodesource.com/setup_$VERSION.x | sudo -E bash -

# Update repositories
apt-get -y update

# Install node package
apt-get -y install nodejs npm
