# Check if script is running as root
bash ../../../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Install snap
bash ../../snap/installSnap.sh

# Install the microk8s snap
snap install microk8s --classic --channel=1.18/stable

# Check the status
microk8s status --wait-ready

# Turn on standard services
microk8s enable dns dashboard registry helm3
