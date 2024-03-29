#!/bin/bash

function usage {
    echo "Example: checkIfCommandExists.sh <wanted_command>"
    echo "The script returns 0 if exists, else 1"
}

DIRECTORY=$(readlink -f $0)

# Check amount of parameters
bash ${DIRECTORY%/*}/checkParameterCount.sh 1 $#
test $? -eq 0 || (usage && exit)

# Check if given command exists
if [[ $(which $1) != "" ]]; then
    echo "The command $1 is already installed"
    exit 0
fi;

exit 1
