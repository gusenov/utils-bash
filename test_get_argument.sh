#!/bin/bash 

source "./get_argument.sh" "your_variable_name" "your_default_value" "y" "your_long_option" "$@"
echo "$your_variable_name"
