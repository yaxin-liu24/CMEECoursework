# Clear workspace and close all graphics
rm(list = ls())  
graphics.off()

# Load necessary functions
source("Yaxin_Liu_HPC_2024_main.R")

# Read the job index from the cluster
iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))  

#iter <- 1  

# Set a unique random seed
set.seed(iter)

# Assign community size based on iter
if (iter <= 25) {
  size <- 500
} else if (iter <= 50) {
  size <- 1000
} else if (iter <= 75) {
  size <- 2500
} else {
  size <- 5000
}

# Construct a unique filename (renamed to "neutral_output_")
output <- paste("neutral_output_", iter, ".rda", sep="")

print(paste("Output file:", output))

# Run
neutral_cluster_run(0.004285, size, 5, 1, size/10, 8*size, output)
