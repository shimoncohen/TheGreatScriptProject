DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Set GDAL environment variables
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal

# Add gis repository
bash ${DIRECTORY%/*}/../../validation/addRepositoryIfNotPresent.sh ppa:ubuntugis/ppa

# Install dependencies
apt-get update -y
apt-get -y install --no-install-recommends \
    libgeos-dev\
    libgdal-dev\
    gdal-bin

# Install GDAL
pip install GDAL==$(gdal-config --version | awk -F'[.]' '{print $1"."$2}') --global-option=build_ext --global-option="-I/usr/include/gdal"
