DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/checkRootPrivileges.sh
test $? -eq 0 || exit

function usage {
    echo "Expecting one parameter."
    echo "The parameter should be a valid PPA string."
    echo "example: addRepositoryIfNotPresent.sh \"deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable\""
}

# Check amount of parameters
bash ${DIRECTORY%/*}/checkParameterCount.sh 1 $#
test $? -eq 0 || (usage && exit 1)

PPA=$1

# From: https://askubuntu.com/questions/381152/how-to-check-if-ppa-is-already-added-to-apt-sources-list-in-a-bash-script and https://stackoverflow.com/questions/4749330/how-to-test-if-string-exists-in-file-with-bash

# If PPA does not exist
if ! grep -Fxq "$PPA" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    # Add PPA
    add-apt-repository -y "$PPA"
fi
