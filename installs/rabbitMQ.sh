DIRECTORY=$(readlink -f $0)

# Check if script is running as root
bash ${DIRECTORY%/*}/../validation/checkRootPrivileges.sh
test $? -eq 0 || exit

# Check if command is already installed
bash ${DIRECTORY%/*}/../validation/checkIfCommandExists.sh rabbitmq-server
test $? -eq 1 || exit

# From: https://tecadmin.net/install-rabbitmq-server-on-ubuntu/

# Enable RabbitMQ PPA repository
echo 'deb http://www.rabbitmq.com/debian/ testing main' | sudo tee /etc/apt/sources.list.d/rabbitmq.list

# Import rabbitmq signing key
wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | sudo apt-key add -

apt-get -y update

# Install RabbitMQ
apt-get -y install rabbitmq-server

# To start service:
# service rabbitmq-server start

# To stop service:
# service rabbitmq-server stop
