"""
This script processes a CSV file containing taxa data to identify and extract entries that belong to the oak genus (Quercus).
It utilizes regular expressions to match oak species names and outputs the found oak species to a new CSV file.

Modules used:
- sys: Provides access to command-line arguments and system-specific parameters.
- re: Enables pattern matching in strings using regular expressions.
- csv: Facilitates reading from and writing to CSV (Comma-Separated Values) files.

Usage:
Run the script from the command line. Ensure the input CSV file exists at '../data/TestOaksData.csv' 
and that you have write permissions for the output file at '../results/JustOaksData.csv'.
"""

import sys
import re
import csv

# checks if a given name is likely an oak species (genus Quercus).
def is_an_oak(name):

# Docstring: Provides examples of how the function works using doctest, which allows for easy testing of functions.
# The function will return True for names like "Quercus robur" and "Quercuss robur", while returning False for names like "Fraxinus excelsior".
    """
    Returns True if the name is likely an oak (genus Quercus), False otherwise.
    
    >>> is_an_oak('Quercus robur')
    True
    >>> is_an_oak('Fraxinus excelsior')
    False
    >>> is_an_oak('Quercuss robur')
    True
    >>> is_an_oak('Quercuus robur')
    True
    """
# r'Querc[us]{2,3}\b' checks if the name starts with "Querc" followed by either two or three 'u's or 's' (e.g., "Quercus" or "Quercuss") and is followed by a word boundary (\b).
# The re.IGNORECASE flag allows the matching to be case-insensitive.
# return bool(re.match(r'Querc[us]{2,3}\b', name, re.IGNORECASE))

def main(argv):
    """
    Reads a CSV file containing taxa data, checks each entry to see if it is an oak, 
    and writes the oak entries to a new CSV file.

    The input file is expected at '../data/TestOaksData.csv', and the output will 
    be written to '../results/JustOaksData.csv'.
    """
    with open('../data/TestOaksData.csv', 'r') as f, open('../results/JustOaksData.csv', 'w') as g:
        taxa = csv.reader(f)
        csvwrite = csv.writer(g)
        csvwrite.writerow(next(taxa))  # Write header
        
        oaks = set()
        for row in taxa:
# Calls is_an_oak with the first column of the row (row[0]).
# If it returns True, prints a message indicating an oak was found, writes the entire row to the output file, and adds the oak name to the oaks set.
            if is_an_oak(row[0]):
                print(f'FOUND AN OAK: {row[0]}')
                csvwrite.writerow(row)
                oaks.add(row[0])
        
        print(f"Found {len(oaks)} oak species: {', '.join(oaks)}")
        
# Imports doctest and runs doctest.testmod(), which checks that the examples in the docstrings of the functions behave as documented.
# Calls the main function, passing in command-line arguments (sys.argv).
if __name__ == "__main__":
    import doctest
    doctest.testmod()
    main(sys.argv)
