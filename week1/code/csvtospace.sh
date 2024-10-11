#!/bin/bash
# Author: Yaxin yaxin.liu24@imperial.ac.uk
# Script: csvtospace.sh
# Description: Convert CSV file to space-separated values file.
# Arguments: 1 -> Input CSV file
# Date: Oct 2024
# Function to display usage information

# Check if correct number of arguments is provided
# "$#" gives the total number of arguments that were passed to the script when it was executed.
if [ $# -ne 1 ]; then 
    echo "Error: Wrong number of arguments."
    usage
    exit 1
fi

input_file="$1"

# Check if the input file exists and is readable
# "!" negates the condition
# -f (file): This operator tests if a file exists and is a regular file
if [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' does not exist."
    exit 1
fi

# tests for the opposite of "readable". It's true if the file either doesn't exist or exists but is not readable
if [ ! -r "$input_file" ]; then
    echo "Error: Input file '$input_file' is not readable."
    exit 1
fi
# Define the output directory (relative path)
output_dir="../results"
# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Get the base name of the input file
base_name=$(basename "$input_file")

# Create output filename 
output_file="$output_dir/${base_name%.csv}.csv"

# Convert CSV to space-separated values
if ! tr ',' ' ' < "$input_file" > "$output_file"; then
    echo "Error: Failed to convert the file."
    exit 1
fi

echo "Successfully converted '$input_file' to '$output_file'"
