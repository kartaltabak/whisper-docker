#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_file.mp3>"
    exit 1
fi

input_file="$1"

output_file="${input_file%.*}.srt"

whisper_timestamped "${input_file}" --output_dir /tmp --output_format srt --model tiny --model_dir cache --accurate

if [ $? -eq 0 ]; then
    echo "Conversion successful: $output_file"
else
    echo "Conversion failed"
    exit 1
fi

cp /tmp/*.srt ./"{output_file}"

