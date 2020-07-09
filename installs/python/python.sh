#!/bin/bash

DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

VERSION=2.7
DEVELOPMENT=0

function usage {
    echo "Run python.sh to install default version 2.7"
    echo "Run python.sh --version <wanted_version> to install a different version"
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
        --dev)
        DEVELOPMENT=1
        shift # Remove
        ;;
    esac
done

# Check if command is already installed
bash ${DIRECTORY%/*}/../../validation/checkIfCommandExists.sh python$VERSION
test $? -eq 1 || exit

# Add python repository
bash ${DIRECTORY%/*}/../../validation/addRepositoryIfNotPresent.sh ppa:deadsnakes/ppa

# Update packages
apt-get -y update

MAJOR=$(echo $VERSION | grep -oP '^[0-9]*')

# If version is 2.* then major is blank to represent default python
if [ $MAJOR -eq 2 ]; then
    MAJOR=''
fi

# Install dependencies
apt-get -y install --no-install-recommends \
    python$VERSION\
    python$MAJOR-pip

# If should install development tools
if [ $DEVELOPMENT -eq 1 ]; then
    apt-get -y install --no-install-recommends python$VERSION-dev
fi

# Upgrade pip
python$VERSION -m pip install --upgrade --force pip
