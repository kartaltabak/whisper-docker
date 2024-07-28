#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_file.srt>"
    exit 1
fi

input_file="$1"

output_file="${input_file%.*}_tr.srt"

python "$( dirname "${BASH_SOURCE[0]}" )"/translate_using_opus.py "${input_file}" "${output_file}"

if [ $? -eq 0 ]; then
    echo "Conversion successful: $output_file"
else
    echo "Conversion failed"
    exit 1
fi


