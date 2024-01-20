#!/bin/bash

set -e

SOURCE="${1}"
TARGET_AUDIO_TRACK="${2}"
TARGET_SUBTITLE="${3}"
DEST="${4}"

if [[ "${SOURCE}" == "" ]]; then
    echo "Usage: `pwd`/`basename "$0"` SOURCE TARGET_AUDIO_TRACK TARGET_SUBTITLE DEST"
    exit 1
fi

# SOURCE
if [[ "${SOURCE}" == "" ]]; then
    echo "SOURCE not specified!"
    exit 1
fi

if [[ ! -d "${SOURCE}" ]]; then
    echo "SOURCE=${SOURCE} doesn't exist!"
    exit 1
fi

echo "Using SOURCE=${SOURCE}"

# DEST
if [[ ! -d "${DEST}" ]]; then
    echo "DEST=${DEST} directory doesn't exist!"
    exit 1
fi

echo "Using DEST=${DEST}"

# TARGET_AUDIO_TRACK
if [[ "${TARGET_AUDIO_TRACK}" == "" ]]; then
    echo "TARGET_AUDIO_TRACK not specified!"
    exit 1
fi

TARGET_AUDIO_TRACK_NUM=$((TARGET_AUDIO_TRACK-1))

if [[ ${TARGET_AUDIO_TRACK_NUM} -lt 0 ]]; then
    echo "TARGET_AUDIO_TRACK_NUM should be >= 0"
    exit 1
fi

echo "Using TARGET_AUDIO_TRACK=${TARGET_AUDIO_TRACK}"
echo "Using TARGET_AUDIO_TRACK_NUM=${TARGET_AUDIO_TRACK_NUM}"

# TARGET_SUBTITLE

if [[ "${TARGET_SUBTITLE}" != "" ]]; then
    TARGET_SUBTITLE_NUM=$((TARGET_SUBTITLE-1))

    if [[ ${TARGET_SUBTITLE} -lt 0 ]]; then
        echo "TARGET_SUBTITLE should be >= 0"
        exit 1
    fi

    echo "Using TARGET_SUBTITLE=${TARGET_SUBTITLE}"
    echo "Using TARGET_SUBTITLE_NUM=${TARGET_SUBTITLE_NUM}"
fi

ls ${SOURCE} | grep -E "^.*\.mkv$" | while read FILE; do
    echo "Converting [${SOURCE}/${FILE}] -> [${DEST}/${FILE}] .."
    if [[ -f "${DEST}/${FILE}" ]]; then
        rm -fv "${DEST}/${FILE}"
    fi

    if [[ "${TARGET_SUBTITLE_NUM}" -ge 0 ]]; then
        ffmpeg -nostdin -loglevel quiet -stats -i ${SOURCE}/${FILE} -map 0:v -map 0:a:${TARGET_AUDIO_TRACK_NUM} -map 0:s:${TARGET_SUBTITLE_NUM} -c copy ${DEST}/${FILE}
    else
        ffmpeg -nostdin -loglevel quiet -stats -i ${SOURCE}/${FILE} -map 0:v -map 0:a:${TARGET_AUDIO_TRACK_NUM} -c copy ${DEST}/${FILE}
    fi
done

exit 0
