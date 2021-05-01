#!/bin/bash
set -e

MOUNT_POINT="${1}"

if [[ "${MOUNT_POINT}" = "" ]]; then
    echo "Usage: `dirname "${0}"` /Volumes/ltfs"
    echo ""
    exit 1
fi

if [[ ! -d "${MOUNT_POINT}" ]]; then
    echo "Mount point [${MOUNT_POINT}] doesn't exist .."
    echo ""
    exit 1
fi

fuser -cu ${MOUNT_POINT}

exit 0


