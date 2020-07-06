DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

##### From: https://code.visualstudio.com/docs/setup/linux

# Add VSCode repository
bash ${DIRECTORY%/*}/../../validation/checkIfCommandExists.sh code
test $? -eq 1 || (curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list')

#curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
#install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/

# Add repository
#sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# Remove temp file
#rm packages.microsoft.gpg

# Install dependencies
apt-get -y install apt-transport-https

# Update repositories
apt-get update

# Install VSCode
apt-get install code
