# Check if script is running as root
bash ../checkRootPrivilages.sh
test $? -eq 0 || exit

apt-get -y install git-all
