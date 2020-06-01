# From: https://stackoverflow.com/questions/18215973/how-to-check-if-running-as-root-in-a-bash-script
# Check if script is running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

##### From: https://code.visualstudio.com/docs/setup/linux

# Install repository key
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
rm packages.microsoft.gpg

# Install dependencies
apt-get -y install apt-transport-https

# Update repositories
apt-get update

# Install VSCode
apt-get install code
