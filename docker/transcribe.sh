#!/bin/bash

usage() {
    echo "Usage: $0 <input_file>"
    exit 1
}

if [ "$#" -lt 1 ]; then
    usage
fi

input_file="$1"

if [ -z "$input_file" ]; then
    usage
fi

python3 /usr/local/bin/transcribe.py --input "${input_file}"

