#!/bin/bash

if [[ ! $1 ]]; then
    echo "Usage: $0 /path/to/clean"
    exit 0
fi


if [[ ! -d "$1" ]]; then
    echo "Path: $1 does not exist."
    exit 0
fi

find "$1" -name ".DS_Store" -type f -exec rm '{}' \;
find "$1" -name ".Trashes" -exec rm -rf '{}' \;
find "$1" -name ".fseventsd" -type d -exec rm -rf '{}' \;
find "$1" -name ".Spotlight*" -type d -exec rm -rf '{}' \;
find "$1" -name "*._.*" -exec rm -rf '{}' \;
find "$1" -name "Thumbs.db" -type f -exec rm '{}' \;
find "$1" -name "ehthumbs.db" -type f -exec rm '{}' \;
