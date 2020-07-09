#!/bin/bash

DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Set GDAL environment variables
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal

VERSION=2.7

function usage {
    echo "Run gdal.sh to install gdal on default python version 2.7"
    echo "Run gdal.sh --python-version <wanted_version> to install gdal on a different version of python"
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
        --python-version=*)
        VERSION="${arg#*=}"
        shift # Remove
        ;;
        --python-version)
        VERSION="$2"
        shift # Remove
        shift
        ;;
    esac
done

# Check if command is already installed
bash ${DIRECTORY%/*}/../validation/checkIfCommandExists.sh gdalinfo
test $? -eq 1 || exit

MAJOR=$(echo $VERSION | grep -oP '^[0-9]*')

# Install python
bash ${DIRECTORY%/*}/python/python.sh --version $VERSION

# Add gis repository
bash ${DIRECTORY%/*}/../../validation/addRepositoryIfNotPresent.sh ppa:ubuntugis/ppa

# Install dependencies
apt-get update -y
apt-get -y install --no-install-recommends \
    libgeos-dev\
    libgdal-dev\
    gdal-bin

# Install GDAL
pip$MAJOR install GDAL==$(gdal-config --version | awk -F'[.]' '{print $1"."$2}') --global-option=build_ext --global-option="-I/usr/include/gdal"
