#!/bin/sh
# Author: Yaxin yaxin.liu24@imperial.ac.uk
# Script: ConcatenateTwoFiles.sh
# Desc: Concatenate the two input files into the output file
# Arguments: <input_file1> [input_file2] ...
# Date: Oct 2024

# Check if exactly two arguments are provided
# "$#": This holds the count of arguments passed to the script.
# -ne: This means "not equal."
# 2: the expected number of arguments.

if [ "$#" -ne 2 ]; then
    echo "Error: Please provide exactly two input files."
    echo "Usage: $0 <input_file1> <input_file2>"
    exit 1
fi

# Define the output directory (relative path)
output_dir="../results"

# Create the output directory if it doesn't exist
# mkdir: command used to create new directories.
# -p: allows the creation of nested directories and prevents errors if the directory already exists.

mkdir -p "$output_dir"

# Check if the input files exist
for file in "$1" "$2"; do
    if [ ! -f "$file" ]; then
        echo "Error: File '$file' does not exist."
        exit 1
    fi
done

# Define the output file name and path
output_file="$output_dir/merged_output.txt"

# Concatenate the two input files into the output file
# cat: reads the contents of the file specified and outputs it to standard output
# >: This operator redirects the output to a file
# >>: This operator appends the output to the specified file rather than overwriting it
cat "$1" > "$output_file"
cat "$2" >> "$output_file"

echo "Merged File is saved as: $output_file"