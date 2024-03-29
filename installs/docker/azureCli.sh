#!/bin/bash

DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Check if command is already installed
bash ${DIRECTORY%/*}/../../validation/checkIfCommandExists.sh az
test $? -eq 1 || exit

# Update repository information and install the azure-cli package
function installCli {
    
    # Update apt packages
    apt-get update

    # Install the cli package
    apt-get -y install azure-cli
}

# Get packages needed for the install process
apt-get update
apt-get -y install ca-certificates curl apt-transport-https lsb-release gnupg

# Download and install the Microsoft signing key
curl -sL https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null

# Add the Azure CLI software repository
AZ_REPO=$(lsb_release -cs)
bash ${DIRECTORY%/*}/../../validation/addRepositoryIfNotPresent.sh "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main"

installCli

# If the install didn't work
if [ $? -ne 0 ]; then
    
    # Add a different Azure CLI repository
    bash ${DIRECTORY%/*}/../../validation/addRepositoryIfNotPresent.sh "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ xenial main"
    
    installCli
fi
