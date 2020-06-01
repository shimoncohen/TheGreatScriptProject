# Check if script is running as root
bash ../checkRootPrivilages.sh
test $? -eq 0 || exit

# Add postgres reository
curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# Install dependencies
apt-get -y update &&\
	apt-get -y install --no-install-recommends \
        postgresql-12\
        postgis\
        postgresql-contrib\
        postgresql-12-postgis-2.5\
        pgadmin4

# Start postgres service:
#service postgresql start

# Stop postgres service:
#service postgresql start
