# From: https://stackoverflow.com/questions/18215973/how-to-check-if-running-as-root-in-a-bash-script
# Check if script is running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

############################### install basics ###############################
bash ./installUsefullPackages.sh
bash ./snap/installSnap.sh

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
        --kubernetes)
        AZURE=1
        shift # Remove
        ;;
    esac
done


##### Check cases from arguments

# Install development tools
if [ "$DEV" -eq 1 ]; then
    bash ./python/installPython3.6.sh
    bash ./git.sh
	bash ./installVisualStudioCode.sh
fi

# Install docker
if [ "$DOCKER" -eq 1 ]; then
	bash ./docker/installDocker.sh
fi

# Install kubernetes and microk8s
if [ "$KUBERNETES" -eq 1 ]; then
	bash ./docker/installDocker.sh
    bash ./docker/installKubernetes.sh
    bash ./docker/installMicrok8s.sh
fi

# Install azure-cli
if [ "$AZURE" -eq 1 ]; then
	bash ./docker/installAzureCli.sh
fi

# Install web development tools
if [ "$WEB_DEV" -eq 1 ]; then
	bash ./installNode.sh
fi

####################### specific for *my* old computer #######################


# Install tools for hdajackretask - tool for sound settings (because computer thinks earphones are always connected)
apt-get -y install alsa-tools-gui
