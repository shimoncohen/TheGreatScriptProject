#!/bin/bash

######## Play on linux lets you install windows applications on linux ########

DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Check if command is already installed
bash ${DIRECTORY%/*}/../validation/checkIfCommandExists.sh playonlinux
test $? -eq 1 || exit

# Install wine
bash ${DIRECTORY%/*}/wine.sh

# Add repository key
#wget -q "http://deb.playonlinux.com/public.gpg" -O- | apt-key add -

# Add repository
#wget http://deb.playonlinux.com/playonlinux_stretch.list -O /etc/apt/sources.list.d/playonlinux.list

# Update repositories
apt-get -y update

# Install playonlinux and dependencies
#apt-get -y install ia32-libs xterm playonlinux
apt-get -y install xterm playonlinux