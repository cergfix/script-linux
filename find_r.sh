#!/bin/bash

if [[ "$1" = "" || "$2" = "" || "$3" = "" ]]; then
    echo "Example: ./find_r.sh "." "*.php" "teststring""
    exit 1
else
    echo "find $1 -name \"$2\" -print0 | xargs -0 grep -n -H \"$3\""
    find $1 -name "$2" -print0 | xargs -0 grep -n -H "$3"
fi

exit 0
