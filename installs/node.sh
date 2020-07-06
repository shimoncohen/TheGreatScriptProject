DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Add node repository
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

# Update repositories
apt-get -y update

# Install node package
apt-get -y install nodejs npm
