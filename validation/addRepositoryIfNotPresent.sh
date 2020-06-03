# Check if script is running as root
bash ./checkRootPrivileges.sh
test $? -eq 0 || exit

function usage {
    echo "Expecting one parameter."
    echo "The parameter should be a valid PPA string."
    echo "example: addRepositoryIfNotPresent.sh \"deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable\""
}

# Check that 1 parameter was given
if [ "$#" -ne 1 ]; then
	usage
	exit 1
fi

PPA=$1

# From: https://askubuntu.com/questions/381152/how-to-check-if-ppa-is-already-added-to-apt-sources-list-in-a-bash-script and https://stackoverflow.com/questions/4749330/how-to-test-if-string-exists-in-file-with-bash

# If PPA does not exist
if ! grep -Fxq "$PPA" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    # Add PPA
    add-apt-repository $PPA
fi
