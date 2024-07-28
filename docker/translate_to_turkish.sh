#!/bin/bash

usage() {
    echo "Usage: $0 <input_file.srt> [--output_file <output_file.srt>]"
    exit 1
}

if [ "$#" -lt 1 ]; then
    usage
fi

input_file=""
output_file=""

while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --output_file)
            if [ -n "$2" ] && [[ "$2" != --* ]]; then
                output_file="$2"
                shift 2
            else
                echo "Error: --output_file requires a non-empty argument."
                usage
            fi
            ;;
        *)
            if [ -z "$input_file" ]; then
                input_file="$1"
                shift
            else
                echo "Unknown parameter: $1"
                usage
            fi
            ;;
    esac
done

if [ -z "$input_file" ]; then
    usage
fi

if [ -z "$output_file" ]; then
    output_file="${input_file%.*}_tr.srt"
fi

python "$( dirname "${BASH_SOURCE[0]}" )"/translate_using_opus.py "${input_file}" "${output_file}"

if [ $? -eq 0 ]; then
    echo "Conversion successful: $output_file"
else
    echo "Conversion failed"
    exit 1
fi
