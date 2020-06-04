DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../../../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Install snap
bash ${DIRECTORY%/*}/../../snap/snap.sh

# Install the microk8s snap
snap install microk8s --classic --channel=1.18/stable

# Check the status
microk8s status --wait-ready

# Turn on standard services
microk8s enable dns dashboard registry helm3
