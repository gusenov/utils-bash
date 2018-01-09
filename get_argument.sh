#!/bin/bash 

# Usage:
#  $ cat your_script.sh
#  #!/bin/bash
#  source "./utils-bash/get_argument.sh" "your_variable_name" "your_default_value" "y" "your_long_option" "$@"
#  echo "$your_variable_name"
#
#  $ ./your_script.sh
#  your_default_value
#
#  $ ./your_script.sh --your_long_option="your value provided through long option"
#  your value provided through long option
#
#  $ ./your_script.sh -y="your value provided through short option"
#  your value provided through short option

parse_command_line_arguments() {
    local variable_name="$1"
    local default_value="$2"
    
    declare -g $variable_name="$default_value"
    # When declare is used within a shell function, the -g option causes all operations on variables to take effect in global scope.
    # If not used in a shell function, -g has no effect.
    # https://www.computerhope.com/unix/bash/declare.htm#syntax
    
    local short_option="-$3=*"
    local long_option="--$4=*"

    for i in "$@"
    do
    case $i in
        $short_option|$long_option)
            declare -g $variable_name="${i#*=}"
            ;;
        *)
            :
    esac
    done
}

parse_command_line_arguments "$@"
