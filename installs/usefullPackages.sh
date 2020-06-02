# Check if script is running as root
bash ../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Update repositories
apt-get -y update

# Install packages
apt-get -y install \
    wget\
    curl\
    nano
