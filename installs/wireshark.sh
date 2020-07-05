DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Add python repository
bash ${DIRECTORY%/*}/../validation/addRepositoryIfNotPresent.sh ppa:wireshark-dev/stable

# Update packages
apt-get -y update

# Install wireshark
apt-get -y install wireshark
