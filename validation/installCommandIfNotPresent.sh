#!/bin/bash

DIRECTORY=$(readlink -f $0)

# Check amount of parameters
bash ${DIRECTORY%/*}/checkParameterCount.sh 1 $#
test $? -eq 0 || exit

# Check if command exists
bash ${DIRECTORY%/*}/checkIfCommandExists.sh $1

# Install command
if [ $? -eq 1 ]; then
	apt-get -y install --no-install-recommends $1
	exit 1
fi

exit 0
