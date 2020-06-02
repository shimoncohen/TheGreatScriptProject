# Check if script is running as root
bash ../../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Install snap
apt-get -y update
apt-get -y install snapd
