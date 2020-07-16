#!/bin/bash

DIRECTORY=$(readlink -f $0)

function usage() {
    echo "checkFileType <file_path> <type>"
}

# Loop through arguments and process them
# Taken from: https://pretzelhands.com/posts/command-line-flags
for arg in "$@"
do
    case $arg in
        --help)
        usage
        shift # Remove --help
        exit
        ;;
    esac
done

# Check amount of parameters
bash ${DIRECTORY%/*}/checkParameterCount.sh 2 $#
test $? -eq 0 || exit

# Check if file exists
bash ${DIRECTORY%/*}/checkFileExists.sh $1
test $? -eq 0 || exit

# If file has wanted extension
if [[ $1 == *.$2 ]]; then
    echo "File $1 is of type .$2"
    exit 0
fi;

echo "File $1 is not of type .$2"
exit 1