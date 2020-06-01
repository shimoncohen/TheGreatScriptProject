# Check if script is running as root
bash ../checkRootPrivilages.sh
test $? -eq 0 || exit

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
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main"

installCli

# If the install didn't work
if [ $? -ne 0 ]; then

    # Remove bad repository
    add-apt-repository -r "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main"
    
    # Add a different Azure CLI repository
    add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ xenial main"
    
    installCli
fi
