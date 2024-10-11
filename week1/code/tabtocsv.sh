#!/bin/sh
# Author: Yaxin yaxin.liu24@imperial.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas

# Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 2024
# Check if the input file is provided
# Check if correct number of arguments is provided
# Function to display usage information

# Check if correct number of arguments is provided
# "$#" gives the total number of arguments that were passed to the script when it was executed.
if [ $# -eq 0 ]; then
    echo "Error: No input file provided."
    usage
    exit 1
fi

if [ $# -ne 1 ]; then
    echo "Error: Incorrect number of arguments."
    usage
    exit 1
fi

input_file="$1"

# "!" negates the condition
# -f (file): This operator tests if a file exists and is a regular file
if [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' does not exist."
    exit 1
fi

# Create the output directory if it doesn't exist
# mkdir: command used to create new directories.
# -p: allows the creation of nested directories and prevents errors if the directory already exists.
output_dir="$(dirname "$0")/../results"
mkdir -p "$output_dir" || { echo "Error: Failed to create output directory."; exit 1; }
    
#basename: used in scripts when need to manipulate file names
base_name=$(basename "$input_file")

#*: matches zero or more characters in file or directory names.
if [[ "$base_name" != *.csv ]]; then
    echo "Error: Input file must have a .csv extension."
    exit 1
fi

output_file="$output_dir/${base_name%.csv}.txt"

#tr ',' ' ': uses translate or delete characters to replace "," with spaces in the input.
#< "$input_file": redirects the contents of the file specified by "$input_file" as input to the tr command.
#> "$output_file": redirects the output of the tr command to the file specified by "$output_file", creating or overwriting that file.
if ! tr ',' ' ' < "$input_file" > "$output_file"; then
    echo "Error: Failed to convert the file."
    exit 1
fi

echo "Successfully converted '$input_file' to '$output_file'"