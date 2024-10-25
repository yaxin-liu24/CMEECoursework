#!/usr/bin/env python3

"""Groupwork Practical on Missing oaks problem"""

__author__ = 'Yaxin Liu,Laiyin Zhou,Sebastian Dohne,Yanfeng Wang'
__version__ = '0.0.1'

import csv
import os

# Define the input and output file paths
input_file = '../data/TestOaksData.csv'
output_file = '../results/oaks.csv'  # Specify the output filename

# Initialize a list to hold oak names
oaks = []

# Ensure the output directory exists
os.makedirs(os.path.dirname(output_file), exist_ok=True)

# Open the input CSV file for reading
with open(input_file, mode='r') as infile:
    reader = csv.reader(infile)
    
    # Read the header row
    headers = next(reader)  # Skip the header
    output_headers = headers  # Store the headers for output

    # Process each row in the CSV file
    for row in reader:
        # Check if the genus is 'Quercus' (oak)
        if row[0].strip().lower() == 'quercus':  # Check genus
            oaks.append(row)

# Write the results to a new CSV file
with open(output_file, mode='w', newline='') as outfile:
    writer = csv.writer(outfile)
    
    # Write the headers
    writer.writerow(output_headers)  # Write the headers
    
    # Write the oak data
    for oak in oaks:
        writer.writerow(oak)

print("Oak names have been written to", output_file)