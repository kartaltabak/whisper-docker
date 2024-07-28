#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 <input_file.mp4> [--output_file <output_file.mp3>]"
    exit 1
}

# Check if at least one argument is provided
if [ "$#" -lt 1 ]; then
    usage
fi

# Initialize variables
input_file=""
output_file=""

# Parse arguments
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

# Check if input file is provided
if [ -z "$input_file" ]; then
    usage
fi

# Set default output file if not provided
if [ -z "$output_file" ]; then
    output_file="${input_file%.*}.mp3"
fi

# Run ffmpeg command to convert input file to output file
ffmpeg -i "$input_file" -q:a 0 -map a "$output_file"

# Check if ffmpeg command was successful
if [ $? -eq 0 ]; then
    echo "Conversion successful: $output_file"
else
    echo "Conversion failed"
    exit 1
fi
