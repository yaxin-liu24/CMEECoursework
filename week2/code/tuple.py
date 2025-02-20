"""
This script processes a tuple containing bird species data, which includes their Latin names, common names, 
and mean body masses. It prints each bird's information on a separate line in a formatted manner.

The data is structured as a tuple of tuples, where each inner tuple contains:
1. Latin name of the bird species
2. Common name of the bird species
3. Mean body mass (in grams) of the bird species
"""

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

# Birds is a tuple of tuples of length three: latin name, common name, mass.
# write a (short) script to print these on a separate line or output block by
# species 
# 
# A nice example output is:
# 
# Latin name: Passerculus sandwichensis Common name: Savannah sparrow Mass: 18.7
# ... etc.
for latin_name, common_name, mass in birds:
#f"" :f-string,to embed expressions inside string literals, making it easy to create dynamic strings.
    print(f"Species: {latin_name}, Common Name: {common_name}, Mass: {mass} ")
