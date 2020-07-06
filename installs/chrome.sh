DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Check if command is already installed
bash ${DIRECTORY%/*}/../validation/checkIfCommandExists.sh chrome
test $? -eq 1 || exit

# Download latest .deb package
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# Install chrome
apt install -y ./google-chrome-stable_current_amd64.deb

# Remove .deb package
rm -r google-chrome-stable_current_amd64.deb