DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../../../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Check if command is already installed
bash ${DIRECTORY%/*}/../../../validation/checkIfCommandExists.sh microk8s
test $? -eq 1 || exit

# Install snap
bash ${DIRECTORY%/*}/../../snap/snap.sh

# From: https://www.billmann.de/post/2019/11/12/setup-microk8s/

# Install the microk8s snap
snap install microk8s --classic

# Check the status
microk8s status --wait-ready

# Turn on standard services
microk8s enable dns dashboard registry helm helm3

# Allow pod to pod, and pod to internet communication
#ufw allow in on cni0 && ufw allow out on cni0
#ufw default allow routed
