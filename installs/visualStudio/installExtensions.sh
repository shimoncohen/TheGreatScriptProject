#!/bin/bash

DIRECTORY=$(readlink -f $0)

function usage() {
    echo "installExtensions.sh <file_with_extension_names>"
    echo "Example: installExtensions.sh extensions.txt"
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
bash ${DIRECTORY%/*}/../../validation/checkParameterCount.sh 1 $#
test $? -eq 0 || exit

# Check amount of parameters
bash ${DIRECTORY%/*}/../../validation/checkFileType.sh $1 "txt"
test $? -eq 0 || exit

while read line; do
    # If a line is a comment or empty
    if [[ $line == \#* ]] || [[ $line == "" ]]; then continue; fi;

    # Install extension
    code --install-extension $line
done < $1 # Give file as input to the loop