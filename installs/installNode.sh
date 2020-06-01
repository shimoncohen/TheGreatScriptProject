# From: https://stackoverflow.com/questions/18215973/how-to-check-if-running-as-root-in-a-bash-script
# Check if script is running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

# Add node repository
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

# Update repositories
apt-get -y update

# Install node package
apt-get -y install nodejs
