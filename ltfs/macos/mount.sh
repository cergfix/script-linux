#!/bin/bash
set -e

MOUNT_POINT="${1}"

if [[ "${MOUNT_POINT}" = "" ]]; then
    echo "Usage: `dirname "${0}"` /Volumes/ltfs"
    echo ""
    exit 1
fi

sudo ltfs ${MOUNT_POINT} -o eject

exit 0
