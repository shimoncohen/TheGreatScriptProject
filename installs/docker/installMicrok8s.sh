# From: https://stackoverflow.com/questions/18215973/how-to-check-if-running-as-root-in-a-bash-script
# Check if script is running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

# Install snap
bash ../snap/installSnap.sh

# Install the microk8s snap
snap install microk8s --classic --channel=1.18/stable

# Check the status
microk8s status --wait-ready

# Turn on standard services
microk8s enable dns dashboard registry helm3
