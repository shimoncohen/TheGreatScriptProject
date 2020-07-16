#!/bin/bash

DIRECTORY=$(readlink -f $0)

function usage() {
    echo "checkFileExists <file_path>"
}

# Check amount of parameters
bash ${DIRECTORY%/*}/checkParameterCount.sh 1 $#
test $? -eq 0 || exit

# Check if file does not exist
if [ ! -f $1 ]; then
    echo "File $1 does not exist"
    exit 1
fi;

echo "File $1 exists"
exit 0