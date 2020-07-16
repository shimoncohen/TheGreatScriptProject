#!/bin/bash

DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Check if command is already installed
bash ${DIRECTORY%/*}/../../validation/checkIfCommandExists.sh minikube
test $? -eq 1 || exit

# Update apt packages
apt-get -y update

# Install dependencies
apt-get -y install curl\
                apt-transport-https\
                virtualbox\
                virtualbox-ext-pack

# Download latest binary
wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

# Copy file to bin
cp minikube-linux-amd64 /usr/local/bin/minikube

# Give file executive permission
chmod 755 /usr/local/bin/minikube

# See installed version
minikube version

# Start minikube
# minikube start

# Stop minikube
# minikube stop

# See minikube status
# minikube status

# Delete single node cluster
# minikube delete

# See addon list
# minikube addons list

# Enable addon (helm, heln3, ingress...)
# minikube addons enable <wanted_addon>

# Disable addon
# minikube addons disable <wanted_addon>