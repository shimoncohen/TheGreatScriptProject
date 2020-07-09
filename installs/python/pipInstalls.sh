#!/bin/bash

DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

VERSION=""
PACKAGES="pipPackages.txt"

function usage {
    echo "Run pipInstalls.sh to install packages listed in pipPackages.txt"
    echo "Run python.sh --version <wanted_version> to install packages on a specific version of pip"
    echo "Run python.sh --packages <path> to install packages from a different file"
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
        --packages)
        PACKAGES="$2"
        shift # Remove
        shift
        ;;
    esac
done

pip$VERSION install -r $PACKAGES
