birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 
#1.
latin_name=[ name[0] for name in birds]
common_name=[ name[1] for name in birds]
mean_body_masses=[ mean[2] for mean in birds]
print(latin_name)
print(common_name)
print(mean_body_masses)
# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 
latin=[]
common=[]
mean=[]
# for bird in birds:
#     latin.append(bird[0])
#     common.append(bird[1])
#     mean.append(bird[2])
index=0
while index<len(birds):
    item=birds[index]
    latin.append(item[0])
    common.append(item[1])
    mean.append(item[2])
    index +=1
print(latin)
print(common)
print(mean)
# A nice example out out is:
# Step #1:
# Latin names:
# ['Passerculus sandwichensis', 'Delichon urbica', 'Junco phaeonotus', 'Junco hyemalis', 'Tachycineata bicolor']
# ... etc.
 