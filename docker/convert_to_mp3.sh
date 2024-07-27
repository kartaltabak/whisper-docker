#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_file.mp4>"
    exit 1
fi

input_file="$1"

output_file="${input_file%.*}.mp3"

ffmpeg -i "$input_file" -q:a 0 -map a "$output_file"

if [ $? -eq 0 ]; then
    echo "Conversion successful: $output_file"
else
    echo "Conversion failed"
    exit 1
fi
