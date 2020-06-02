# Check if script is running as root
bash ../../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

function installDockerPackages {
    
    # Update apt packages
    apt-get -y update

    # Install the latest version of Docker Engine - Community and containerd
    apt-get -y install docker-ce docker-ce-cli containerd.io
}

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
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $DOCKER_REPO stable"

installDockerPackages

# If the install didn't work
if [ $? -ne 0 ]; then

    # Remove bad repository
    add-apt-repository -r "deb [arch=amd64] https://download.docker.com/linux/ubuntu $DOCKER_REPO stable"
    
    # Add a different docker repository
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
    
    installDockerPackages
fi
