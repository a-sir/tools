#!/bin/bash

if [ $# -eq 1 ] && [ -d "${1}" ]; then
    find ${1}  | grep -e "\.mp4$" -e "\.mp3$" | sed 's/\.mp3$//' | sed 's/\.mp4$//' | while read f; do
        if [ -f "${f}.mp4" ] && [ ! -f "${f}.mp3" ]; then
            echo "No mp3 for ${f}.mp4 => submit convertion"
            log="${f}.log"
            echo "(ffmpeg -i \"${f}.mp4\" -vn -acodec libmp3lame -ac 2 -ab 192k -ar 48000 \"/${f}.mp3\" ) 1>\"${log}\" 2>&1 && rm \"${log}\""
        fi
    done | parallel -j 3
fi
