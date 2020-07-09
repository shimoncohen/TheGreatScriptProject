# Get systems supported architectures
SUPPORTED_SYSTEMS=$(lscpu | grep "CPU op-mode(s)" | grep -oP "3.*")

# If supports more than one, then 64 bit, otherwise 32 bit
if [[ $SUPPORTED_SYSTEMS == *","* ]]; then
    echo 64
else
    echo 32
fi
