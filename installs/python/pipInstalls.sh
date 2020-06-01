# Check if script is running as root
bash ../checkRootPrivilages.sh
test $? -eq 0 || exit

# Install python3.6
bash ./installPython3.6.sh

pip install wheel\
            django
