DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Add repository
bash ${DIRECTORY%/*}/../validation/addRepositoryIfNotPresent.sh -y ppa:linuxgndu/sqlitebrowser

# Update repositories
apt-get update

# Install sqliteBrowser
apt-get -y install sqlitebrowser
