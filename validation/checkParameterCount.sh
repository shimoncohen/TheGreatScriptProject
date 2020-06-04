function usage {
    echo 'This script checks that the given amount of parametes to a script is correct.'
    echo
    echo "Flags:"
    echo "--help For explanation on the script"
    echo "--equal To check if the given amount is equal to the expected amount"
    echo "--less-than-equal  To check if the given amount is at least the expected amount"
    echo
    echo "examples:"
    echo "Default is to check if the parameters are equal:"
    echo 'checkParameterCount.sh <wanted_amount> $#'
    echo
    echo "Check if the wanted amount is less than or equal to the amount of parameters:"
    echo 'checkParameterCount.sh --less_than_equal <wanted_amount> $#'
}

CHECK_CONDITION="-eq"
FAILURE_CAUSE="exactly"

# Loop through arguments and process them
# Taken from: https://pretzelhands.com/posts/command-line-flags
for arg in "$@"
do
    case $arg in
        --help)
        usage
        exit 0
        shift # Remove
        ;;
        --equal)
        shift # Remove
        ;;
        --less-than-equal)
        CHECK_CONDITION="-le"
        FAILURE_CAUSE="at least"
        shift # Remove
        ;;
    esac
done

# Hahahahahahaha
# Check that 2 parameters were given
if [ $# -ne 2 ]; then
	usage
    exit 1
fi

# Check the wanted amount of parameters are present
if [ $1 $CHECK_CONDITION $2 ]; then
	exit 0
fi

echo "Wrong amount of arguments given. Expected $FAILURE_CAUSE $1 parameters."
exit 1
