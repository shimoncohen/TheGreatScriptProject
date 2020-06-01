# Check if script is running as root
bash ../checkRootPrivilages.sh
test $? -eq 0 || exit

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
