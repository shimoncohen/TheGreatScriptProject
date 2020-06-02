# Check if script is running as root
bash ../../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

VERSION=2.7

function usage {
    echo "Run python.sh to install default version 2.7"
    echo "Run python.sh --version <wanted_version> to install a different version"
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
        --version=*)
        VERSION="${arg#*=}"
        shift # Remove
        ;;
        --version)
        VERSION="$2"
        shift # Remove
        shift
        ;;
    esac
done

# Add python repository
bash ../../validation/addRepositoryIfNotPresent.sh -y ppa:deadsnakes/ppa

# Update packages
apt-get -y update

# Grab major release
MAJOR=$(echo $VERSION | grep -oP '^[0-9]*')

# Install dependencies
apt-get -y install --no-install-recommends \
    python$VERSION\
    python$MAJOR-pip

# Upgrade pip
python$VERSION -m pip install --upgrade --force pip
