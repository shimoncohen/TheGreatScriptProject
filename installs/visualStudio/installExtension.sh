#!/bin/bash

DIRECTORY=$(readlink -f $0)

# Check amount of parameters
bash ${DIRECTORY%/*}/../../validation/checkParameterCount.sh 1 $#
test $? -eq 0 || exit

code --install-extension $1