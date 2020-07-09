#!/bin/bash

DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# From: https://www.billmann.de/post/2019/11/12/setup-microk8s/

# Enable role base access control, dns and helm on microk8s
microk8s.enable rbac dns helm

# Apply tiller file to cluster
microk8s.kubectl apply -f helm-rbac.yaml

# Initialize helm with tiller
microk8s.helm init --service-account tiller
