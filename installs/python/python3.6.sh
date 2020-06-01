# Check if script is running as root
bash ../checkRootPrivilages.sh
test $? -eq 0 || exit

# Add python repository
add-apt-repository -y ppa:deadsnakes/ppa

# Update packages
apt-get -y update

# Install dependencies
apt-get -y install --no-install-recommends \
    python3.6\
    python3-pip

# Upgrade pip
python3.6 -m pip install --upgrade --force pip
