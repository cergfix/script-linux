#!/bin/bash
set -e

VOLUME_NAME="${1}"
FORCE="${2}"

if [[ "${VOLUME_NAME}" = "" ]]; then
    echo "Usage: `dirname "${0}"` FILM_LTO1 1"
    echo "  or"
    echo "Usage: `dirname "${0}"` FILM_LTO1 force"
    echo ""
    exit 1
fi

VOLUME_NAME_LEN=${#VOLUME_NAME}
if [[ "${VOLUME_NAME_LEN}" -gt "10" ]]; then
    echo "Error: maximum volume name length is 10, got ${VOLUME_NAME_LEN}!"
    exit 1
fi

if [[ "${FORCE}" != "" ]]; then
    mkltfs -d 0 --force --volume-name=${VOLUME_NAME}
else
    mkltfs -d 0 --volume-name=${VOLUME_NAME}
fi

exit 0
