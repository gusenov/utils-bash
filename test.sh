#!/bin/bash

# https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
get_this_dir_path() {
    this_script_path="${BASH_SOURCE[0]}"
    while [ -h "$this_script_path" ]; do  # resolve $this_script_path until the file is no longer a symlink
        dir="$( cd -P "$( dirname "$this_script_path" )" && pwd )"
        this_script_path="$(readlink "$this_script_path")"
        [[ $this_script_path != /* ]] && this_script_path="$dir/$this_script_path"  # if $this_script_path was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    this_dir_path="$( cd -P "$( dirname "$this_script_path" )" && pwd )"
    echo "$this_dir_path"
}

echo_ok() {
    "$(get_this_dir_path)/colored_echo.sh" --text="OK" --colour="green" --format="b"
}

echo_failed() {
    "$(get_this_dir_path)/colored_echo.sh" --text="FAILED" --colour="red" --format="b"
}

result=$(./test_get_argument.sh --your_long_option="your value provided through long option")
if [ "$result" == "your value provided through long option" ]; then
    echo_ok
else
    echo_failed
fi

result=$(./test_get_argument.sh -y="your value provided through short option")
if [ "$result" == "your value provided through short option" ]; then
    echo_ok
else
    echo_failed
fi
