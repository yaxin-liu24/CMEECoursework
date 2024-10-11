#!/bin/sh
# Author: Yaxin yaxin.liu24@imperial.ac.uk
# Script: CountLines.sh
# Desc: Count the number of lines in the file
# Arguments: <input_file> 
# Date: Oct 2024

# Check if exactly one argument is provided
# "$#": This holds the count of arguments passed to the script.
# -ne: This means "not equal."
# 1: the expected number of arguments.

if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly one input file."
    usage
    exit 1
fi

# Check if the file exists and is readable
# -f filename: checks if the specified filename exists and is a regular file 
# -r filename: checks if the specified filename exists and is readable by the user running the script
if [ ! -f "$1" ]; then
    echo "Error: File '$1' does not exist or is not a regular file."
    exit 1
fi

if [ ! -r "$1" ]; then
    echo "Error: File '$1' is not readable."
    exit 1
fi

# Count the number of lines in the file
# wc: word count -l: count only the number of lines.
NumLines=$(wc -l < "$1")

# Display the result
echo "The file '$1' has $NumLines line(s)."

