#!/bin/bash

if [ -n "$1" ] && [ -n "$2" ] && [ -n "$3" ]; then
	echo "find $1 -name $2 -print0 | xargs -0 grep -n -H $3"
	find $1 -name $2 -print0 | xargs -0 grep -n -H $3
else
	echo "EXAMPLE: ./FIND_STRING_IN_FILES_RECURSIVE . *.php teststring find.log"
	echo "     OR: ./FIND_STRING_IN_FILES_RECURSIVE . *.php testring"
fi
