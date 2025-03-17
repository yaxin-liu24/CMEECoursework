rm(list = ls())
graphics.off()

source("Yaxin_Liu_HPC_2024_main.R")

#read in the job number
iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
#iter <- 1  
set.seed(iter)

#Select community size based on iter (25 tasks assigned to each size)
if (iter >= 1 & iter <= 25) {
  size <- 500
} else if (iter >= 26 & iter <= 50) {
  size <- 1000
} else if (iter >= 51 & iter <= 75) {
  size <- 2500
} else {
  size <- 5000
}

# set speciation_rate
speciation_rate <- 0.1  

# Generate a unique file name to avoid overwriting files on the HPC
output_file_name <- file.path(Sys.getenv("TMPDIR"), paste0("q23_simulation_result_", iter, ".rda"))


# calculate parameter
interval_rich <- 1
interval_oct <- size / 10
burn_in_generations <- 8 * size

# run
neutral_cluster_run(
  speciation_rate = speciation_rate,
  size = size,
  wall_time = 11.5,  
  interval_rich = interval_rich,
  interval_oct = interval_oct,
  burn_in_generations = burn_in_generations,
  output_file_name = output_file_name
)


print(paste("Simulation completed for iter:", iter, "size:", size))

