#' This function calculates heights of trees given distance of each tree 
#' from its base and angle to its top, using  the trigonometric formula 
#
#' height = distance * tan(radians)
#
#' ARGUMENTS
#' degrees:   The angle of elevation of tree
#' distance:  The distance from base of tree (e.g., meters)
#
#' OUTPUT
#' The heights of the tree, same units as "distance"

TreeHeight <- function(degrees, distance) {
    radians <- degrees * pi / 180
    height <- distance * tan(radians)
    print(paste("Tree height is:", height))
  
    return (height)
}
# read csv
input_file <- "../data/trees.csv"  
# make sure the input file exists
trees <- read.csv(input_file,header = TRUE, sep = ",") 
# calculate the treeheights and add them to a new column 
library(dplyr)
trees <- trees %>%   
mutate(Tree.Height.m = TreeHeight(Angle.degrees, Distance.m)) 
# save the output as new csv file into results
output_file <- "../results/TreeHts.csv" 
write.csv(trees, file = output_file, row.names = FALSE) 
# print 
print(paste("TreeHeight has been calculated and saved to:", output_file))