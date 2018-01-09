#!/bin/bash 

result=$(./test_get_argument.sh --your_long_option="your value provided through long option")
if [ "$result" == "your value provided through long option" ]; then
    echo "OK"
else
    echo "FAILED"
fi

result=$(./test_get_argument.sh -y="your value provided through short option")
if [ "$result" == "your value provided through short option" ]; then
    echo "OK"
else
    echo "FAILED"
fi
