#!/bin/bash

if [[ ! $1 ]]; then
    echo "Usage: $0 /path/to/*.mp3"
    exit 0
fi

for f in "$1"*.mp3; do
  echo "Processing $f file ..."
  afconvert -f caff -d LEI16@44100 -c 1 "$f" "${f/mp3/caf}"
done
