#!/bin/bash

DIRECTORY=$(readlink -f $0)
DIRECTORY=${DIRECTORY%/*}

# Check if script is running as root
bash $DIRECTORY/../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

############################### install basics ###############################
bash $DIRECTORY/usefullPackages.sh
bash $DIRECTORY/snap/snap.sh

DEV=0
DOCKER=0
KUBERNETES=0
AZURE=0
WEB_DEV=0

# Loop through arguments and process them
# Taken from: https://pretzelhands.com/posts/command-line-flags
for arg in "$@"
do
    case $arg in
        --all)
        DEV=1
        DOCKER=1
        KUBERNETES=1
        AZURE=1
        WEB_DEV=1
        shift # Remove --all from processing
        ;;
        --dev)
        DEV=1
        shift # Remove
        ;;
        --docker)
        DOCKER=1
        shift # Remove
        ;;
        --kubernetes)
        KUBERNETES=1
        shift # Remove
        ;;
        --azure)
        AZURE=1
        shift # Remove
        ;;
    esac
done


##### Check cases from arguments

# Install development tools
if [ "$DEV" -eq 1 ]; then
    bash $DIRECTORY/python/python3.6.sh
    bash $DIRECTORY/git.sh
	bash $DIRECTORY/visualStudioCode.sh
fi

# Install docker
if [ "$DOCKER" -eq 1 ]; then
	bash $DIRECTORY/docker/docker.sh
fi

# Install kubernetes and microk8s
if [ "$KUBERNETES" -eq 1 ]; then
	bash $DIRECTORY/docker/docker.sh
    bash $DIRECTORY/docker/kubernetes.sh
    bash $DIRECTORY/docker/microk8s/microk8s.sh
fi

# Install azure-cli
if [ "$AZURE" -eq 1 ]; then
	bash $DIRECTORY/docker/azureCli.sh
fi

# Install web development tools
if [ "$WEB_DEV" -eq 1 ]; then
	bash $DIRECTORY/node.sh
fi

####################### specific for *my* old computer #######################


# Install tools for hdajackretask - tool for sound settings (because computer thinks earphones are always connected)
apt-get -y install alsa-tools-gui
