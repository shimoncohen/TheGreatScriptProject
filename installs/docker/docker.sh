#!/bin/bash

DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

function usage {
    echo "Run docker.sh to install docker"
    echo "Run docker.sh --user <wanted_version> to add a user to docker group"
}

function installDockerPackages {
    
    # Update apt packages
    apt-get -y update

    # Install the latest version of Docker Engine - Community and containerd
    apt-get -y install docker-ce docker-ce-cli containerd.io
}

USER=""

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
        --user=*)
        USER="${arg#*=}"
        shift # Remove
        ;;
        --user)
        USER="$2"
        shift # Remove
        shift
        ;;
    esac
done

# Uninstall older versions
apt-get remove docker docker-engine docker.io containerd runc

# Update apt packages
apt-get -y update

# Install packages to allow apt to use a repository over HTTPS
apt-get -y install apt-transport-https\
                        ca-certificates\
                        curl\
                        gnupg-agent\
                        software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the docker repository
DOCKER_REPO=$(lsb_release -cs)
bash ${DIRECTORY%/*}/../../validation/addRepositoryIfNotPresent.sh "deb [arch=amd64] https://download.docker.com/linux/ubuntu $DOCKER_REPO stable"

installDockerPackages

# If the install didn't work
if [ $? -ne 0 ]; then
    
    # Add a different docker repository
    bash ${DIRECTORY%/*}/../../validation/addRepositoryIfNotPresent.sh "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
    
    installDockerPackages
fi

if [ "$USER" != "" ]; then
    # Add docker group
    groupadd docker

    # Add a user to docker group
    usermod -aG docker $USER
    newgrp docker
fi