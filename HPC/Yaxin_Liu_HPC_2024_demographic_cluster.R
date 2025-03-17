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

initial_state1 <- c(0, 0, 0, 100)
initial_state2 <- c(0, 0, 0, 10)
initial_state3 <- c(25, 25, 25, 25)
initial_state4 <- c(2.5, 2.5, 2.5, 2.5)
# Assign initial conditions according to iter
if (iter %% 4 == 1) {
  initial_state=initial_state1   # initial condition 1
} else if (iter %% 4 == 2) {
  initial_state=initial_state2   # initial condition 2
} else if (iter %% 4 == 3) {
  initial_state=initial_state3  # initial condition 3
} else if (iter %% 4 == 0) {
  initial_state=initial_state4   # initial condition 4
}
# Initialize the result list
results <- vector("list", 150)
sum_vect <- function(x, y) {
  len_x = length(x)
  len_y = length(y)
  if (len_x < len_y){
    x = c(x,rep(0,len_y-len_x))
  }
  if (len_x > len_y){
    y = c(y,rep(0,len_x-len_y))
  }
  return(x+y)
}
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