#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 <input_file.mp4> [--output_file <output_file.tr.srt>]"
    exit 1
}

# Check if at least one argument is provided
if [ "$#" -lt 1 ]; then
    usage
fi

# Parse options using getopt
OPTIONS=$(getopt -o '' -l output_file: -- "$@")
if [ $? -ne 0 ]; then
    usage
fi
eval set -- "$OPTIONS"

input_file=""
output_file=""

# Extract options and their arguments into variables
while true; do
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
        --)
            shift
            break
            ;;
        *)
            usage
            ;;
    esac
done

# Remaining argument should be the input file
if [ -n "$1" ]; then
    input_file="$1"
    shift
else
    usage
fi

if [ -z "$output_file" ]; then
    output_file="${input_file%.*}.tr.srt"
fi

mp3_file="/tmp/${input_file%.*}.mp3"
srt_file="/tmp/${input_file%.*}.srt"

echo "Converting $input_file to MP3..."
convert_to_mp3 "$input_file" --output_file "$mp3_file"
if [ $? -ne 0 ]; then
    echo "Conversion to MP3 failed"
    exit 1
fi

echo "Creating SRT file from $mp3_file..."
create_srt "$mp3_file" --output_file "$srt_file"
if [ $? -ne 0 ]; then
    echo "Creation of SRT file failed"
    exit 1
fi

echo "Translating $srt_file to Turkish..."
translate_to_turkish "$srt_file" --output_file "$output_file"
if [ $? -ne 0 ]; then
    echo "Translation to Turkish failed"
    exit 1
fi

echo "Translation successful: $output_file"
