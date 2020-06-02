# Check if script is running as root
bash ../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Add repository
bash ../validation/addRepositoryIfNotPresent.sh -y ppa:linuxgndu/sqlitebrowser

# Update repositories
apt-get update

# Install sqliteBrowser
apt-get -y install sqlitebrowser
