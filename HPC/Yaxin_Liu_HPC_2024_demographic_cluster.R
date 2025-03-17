# CMEE 2024 HPC exercises R code pro forma
# For stochastic demographic model cluster run

rm(list=ls()) # good practice 
graphics.off()
source("Demographic.R")
#read in the job number
iter = as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
set.seed(iter)
growth_matrix <- matrix(c(0.1, 0.0, 0.0, 0.0,
                          0.5, 0.4, 0.0, 0.0,
                          0.0, 0.4, 0.7, 0.0,
                          0.0, 0.0, 0.2, 0.4),
                        nrow = 4, ncol = 4, byrow = TRUE)

reproduction_matrix <- matrix(c(0.0, 0.0, 0.0, 2.6,
                                0.0, 0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0, 0.0,
                                0.0, 0.0, 0.0, 0.0),
                              nrow = 4, ncol = 4, byrow = TRUE)
projection_matrix <- reproduction_matrix + growth_matrix
clutch_distribution <- c(0.06, 0.08, 0.13, 0.15, 0.16, 0.18, 0.15, 0.06, 0.03)
# Determine the category of the initial state
condition_index <- (iter %% 4)
if (condition_index == 1) {
  condition <- "big_adult"
  initial_state <- as.integer(c(0, 0, 0, 100))
} else if (condition_index == 2) {
  condition <- "small_adult"
  initial_state <- as.integer(c(0, 0, 0, 10))
} else if (condition_index == 3) {
  condition <- "big_spread"
  initial_state <- as.integer(c(25, 25, 25, 25))
} else {
  condition <- "small_spread"
  initial_state <- as.integer(c(2.5, 2.5, 2.5, 2.5))
}


# Initialize the result list
results <- vector("list", 150)

# Run the simulation 150 times
simulation_length <- 120
for (i in 1:150) {
  results[[i]] <- stochastic_simulation(
    initial_state = initial_state,
    growth_matrix = growth_matrix,
    reproduction_matrix = reproduction_matrix,
    clutch_distribution = clutch_distribution,
    simulation_length = simulation_length
  )
}

# Save the result to a file
save(results, file = paste0("results_iter_", iter, ".RData"))