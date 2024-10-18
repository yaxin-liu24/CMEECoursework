taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a python script to populate a dictionary called taxa_dic derived from
# taxa so that it maps order names to sets of taxa and prints it to screen.
# 
# An example output is:
#  
# 'Chiroptera' : set(['Myotis lucifugus']) ... etc. 
# OR, 
# 'Chiroptera': {'Myotis  lucifugus'} ... etc

#### Your solution here #### 
# taxa_dic = {}
# for (animal, category) in taxa:
#     if category in taxa_dic:
#         taxa_dic[category].add(animal)
#     else:
#         taxa_dic[category] = {animal}
# print(taxa_dic)

# Now write a list comprehension that does the same (including the printing after the dictionary has been created)  
 
#### Your solution here #### 
from collections import defaultdict
# Using defaultdict to create a dictionary of sets
taxa_dic = defaultdict(set)

# Populate the dictionary using list comprehension
{taxa_dic[category].add(animal) for animal, category in taxa}

# Print the resulting dictionary
print(dict(taxa_dic))