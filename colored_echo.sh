#!/bin/bash 

# Usage:
#  $ "./utils-bash/colored_echo.sh" --text="Success" --colour="green" --format="b"
#  $ "./utils-bash/colored_echo.sh" -t="Success" -c="green" -f="b"

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

source "$(get_this_dir_path)/get_argument.sh" "text" "" "t" "text" "$@"
source "$(get_this_dir_path)/get_argument.sh" "colour" "" "c" "colour" "$@"
source "$(get_this_dir_path)/get_argument.sh" "format" "" "f" "format" "$@"

# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
say() {
    echo "$@" | sed \
        -e "s/\(\(@\(red\|green\|yellow\|blue\|magenta\|cyan\|white\|reset\|b\|u\)\)\+\)[[]\{2\}\(.*\)[]]\{2\}/\1\4@reset/      g" \
        -e "s/@red/$(tput setaf 1)/g"     \
        -e "s/@green/$(tput setaf 2)/g"   \
        -e "s/@yellow/$(tput setaf 3)/g"  \
        -e "s/@blue/$(tput setaf 4)/g"    \
        -e "s/@magenta/$(tput setaf 5)/g" \
        -e "s/@cyan/$(tput setaf 6)/g"    \
        -e "s/@white/$(tput setaf 7)/g"   \
        -e "s/@reset/$(tput sgr0)/g"      \
        -e "s/@b/$(tput bold)/g"          \
        -e "s/@u/$(tput sgr 0 1)/g"
}

if [ -n "$colour" ]; then  # http://timmurphy.org/2010/05/19/checking-for-empty-string-in-bash/
    colour="@$colour"
fi

if [ -n "$format" ]; then
    format="@$format"
fi

if [ -n "$colour" ] || [ -n "$format" ]; then  # https://stackoverflow.com/questions/4111475/how-to-do-a-logical-or-operation-in-shell-scripting
    text="[[$text]]"
fi

say "$format$colour$text"
