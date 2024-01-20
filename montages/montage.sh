#!/bin/bash

# brew install imagemagick

set -e

SOURCE="${1}"
DEST="${2}"
DEPTH="${3:-1}"

if [[ "${SOURCE}" == "" ]]; then
    echo "Source directory not specified!"
    exit 1
fi

if [[ ! -d "${SOURCE}" ]]; then
    echo "Source directory ${SOURCE} doesn't exist!"
    exit 1
fi

if [[ ! -d "${DEST}" ]]; then
    echo "Dest directory ${DEST} doesn't exist!"
    exit 1
fi

PATH_DEPTH=""
if [[ "${DEPTH}" != "" && "${DEPTH}" =~ ^[0-9]+$ ]]; then
    for (( i=0; i<${DEPTH}; i++ )); do
        PATH_DEPTH="${PATH_DEPTH}*/"
    done
fi

echo "Using depth (default: 2): ${DEPTH}"

echo "Creating montages from ${SOURCE} .."
find "${SOURCE}" -type f -name "*.jpg" | grep -v "No Scene" | grep -v "No Shot" | grep -v "No Take" | xargs basename | awk -F "-" '{print $1}' | sort | uniq | while read SCENE; do
    if [[ "${SCENE}" != "" ]]; then
        echo "Rendering SCENE: ${SCENE}-*"
        montage -density 1000 -tile 2x0 -border 3 -geometry +0+0 ${SOURCE}/${PATH_DEPTH}${SCENE}-* ${DEST}/${SCENE}-montage.jpg
    fi
done

exit 0
