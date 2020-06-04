DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

function installPackages {

    # Upgrade pip to latest version
    python3.5 -m pip install --upgrade pip

    # Install needed python packages
    python3.5 -m pip install setuptools wheel
    python3.5 -m pip install psycopg2

    # Update repositories
    apt-get -y update

    # Install dependencies
    apt-get -y install --no-install-recommends \
        postgresql-12\
        postgis\
        postgresql-contrib\
        postgresql-12-postgis-2.5\
        pgadmin4
}

# Add postgres reository
curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

installPackages

# If there was a problem with the repository
if [ $? -ne 0 ]; then

    sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

    installPackages
fi

# Start postgres service:
#service postgresql start

# Stop postgres service:
#service postgresql stop
