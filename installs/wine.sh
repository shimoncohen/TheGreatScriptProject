DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Get system architecture
ARCHITECTURE=$(bash ../getArchitecture.sh)

# If the system is 64 bit, enable 32 bit architecture
if [ $ARCHITECTURE -eq 64 ]; then
    dpkg --add-architecture i386
fi

# Add the WineHQ signing key
wget -qO- https://dl.winehq.org/wine-builds/Release.key | sudo apt-key add -

# Add the relevant repository from the WineHQ
bash ${DIRECTORY%/*}/../validation/addRepositoryIfNotPresent.sh 'deb http://dl.winehq.org/wine-builds/ubuntu/ xenial main'

# Update repositories
apt-get -y update

# Install wine
apt-get -y install --install-recommends --allow-unauthenticated winehq-stable
