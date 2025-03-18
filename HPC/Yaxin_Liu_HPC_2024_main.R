# CMEE 2024 HPC exercises R code main pro forma
# You don't HAVE to use this but it will be very helpful.
# If you opt to write everything yourself from scratch please ensure you use
# EXACTLY the same function and parameter names and beware that you may lose
# marks if it doesn't work properly because of not using the pro-forma.

name <- "Yaxin Liu"
preferred_name <- "Yaxin"
email <- "yaxin.liu24@imperial.ac.uk"
username <- "yaxin"

# Please remember *not* to clear the work space here, or anywhere in this file.
# If you do, it'll wipe out your username information that you entered just
# above, and when you use this file as a 'toolbox' as intended it'll also wipe
# away everything you're doing outside of the toolbox.  For example, it would
# wipe away any automarking code that may be running and that would be annoying!

# Section One: Stochastic demographic population model

# Question 0

state_initialise_adult = function(num_stages, initial_size) {
  # Create a state vector of length num_stages
  state = rep(0, num_stages)
  # Assign the entire population to the adult life stage (final stage)
  state[num_stages] = initial_size
  return(state)
}
state_initialise_spread = function(num_stages, initial_size){
  starting_allocation = floor(initial_size/num_stages)
  remainder = initial_size%%num_stages
  state = rep(starting_allocation,num_stages)
  if (remainder>0){
    state[1:remainder]=state[1:remainder]+1
  }
  return(state)
}

# Question 1
source("Demographic.R")
question_1 <- function(){
  
  initial_state1 <- c(0, 0, 0, 100)
  initial_state2 <- c(25, 25, 25, 25)
  simulation_length = 24
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
  projection_matrix = reproduction_matrix + growth_matrix
  population_1 = deterministic_simulation(initial_state1, projection_matrix, simulation_length)
  population_2 = deterministic_simulation(initial_state2, projection_matrix, simulation_length)
  # png(filename="question_1", width = 600, height = 400)
  # plot your graph here
  
  library(ggplot2)
  
  
  time_steps <- 0:simulation_length
  data <- data.frame(
    Time = rep(time_steps, 2),
    Population = c(population_1, population_2),
    Condition = rep(c("All Adults", "Even Distribution"), each = length(time_steps))
  )
  
  
  dev.new()  
  p <- ggplot(data, aes(x = Time, y = Population, color = Condition)) +
    geom_line(size = 1) +  
    labs(
      title = "Population Dynamics: Two Initial Conditions",
      x = "Time (Steps)",
      y = "Total Population Size",
      color = "Initial Condition"  
    ) +
    theme_minimal() +  
    theme(
      plot.title = element_text(hjust = 0.5, size = 14),  
      legend.position = "top"  
    )
  
  return(paste("The initial distribution of individuals across life stages affects the early growth dynamics.",
               "When all individuals are adults, the population grows faster initially due to high reproduction rates.",
               "However, when individuals are evenly distributed, the growth starts slower but becomes more stable over time.",
               collapse = "\n"))
  
}
question_1()

# Question 2
source("Demographic.R")
question_2 <- function(){
  initial_state1 <- c(0, 0, 0, 100)
  initial_state2 <- c(25, 25, 25, 25)
  simulation_length = 24
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
  clutch_distribution = c(0.06,0.08,0.13,0.15,0.16,0.18,0.15,0.06,0.03)
  # call stochastic_simulation
  population_1 <- stochastic_simulation(
    initial_state = initial_state1,
    growth_matrix = growth_matrix,
    reproduction_matrix = reproduction_matrix,
    clutch_distribution = clutch_distribution,
    simulation_length = simulation_length
  )
  
  population_2 <- stochastic_simulation(
    initial_state = initial_state2,
    growth_matrix = growth_matrix,
    reproduction_matrix = reproduction_matrix,
    clutch_distribution = clutch_distribution,
    simulation_length = simulation_length
  )
  
  # Create time steps
  time_steps <- 0:simulation_length
  
  # Create a data frame for drawing
  data <- data.frame(
    Time = rep(time_steps, 2),
    Population = c(population_1, population_2),
    Condition = rep(c("All Adults", "Even Distribution"), each = length(time_steps))
  )
  # plot your graph here
  # Save chart as question_2.png
  png(filename = "question_2.png", width = 600, height = 400)
  
  library(ggplot2)
  p2 <- ggplot(data, aes(x = Time, y = Population, color = Condition)) +
    geom_line(size = 1) +  # Draw a line chart
    labs(
      title = "Stochastic Simulation: Two Initial Conditions",
      x = "Time (Steps)",
      y = "Total Population Size",
      color = "Initial Condition"
    ) +
    theme_minimal() +  # Set theme
    theme(
      plot.title = element_text(hjust = 0.5, size = 14),
      legend.position = "top"
    )
  
  # Print and save the plot
  print(p2)
  
  dev.off()  # Close the graphics device
  
  # Return a written answer
  return("Stochastic simulations produce less smooth curves than deterministic simulations because random variation in birth, death, and survival events introduces noise. This randomness is absent in deterministic simulations, which rely on fixed average rates for predictions.")
}


# Questions 3 and 4 involve writing code elsewhere to run your simulations on the cluster


# Question 5
question_5 <- function(){
  
  # Get all RData files
  files <- list.files(pattern = "*.RData")
  
  # Store extinction statistics
  extinction_counts <- c(0, 0, 0, 0)
  total_simulations <- c(0, 0, 0, 0)
  
  # Walk through each file
  for (file in files) {
    load(file)  
    
    # Extract iter value (number in file name)
    iter <- as.numeric(gsub("\\D", "", file))  # 提取文件名中的数字
    
    # Calculates the initial conditions for the file
    condition_index <- (iter %% 4)
    if (condition_index == 0) {
      condition_index <- 4  # iter=4,8,12... 对应初始条件 4
    }
    
    # Count the number of extinctions in this file（final population size = 0）
    extinct_count <- sum(sapply(results, function(sim) tail(sim, 1) == 0))
    
    # Update statistics
    extinction_counts[condition_index] <- extinction_counts[condition_index] + extinct_count
    total_simulations[condition_index] <- total_simulations[condition_index] + length(results)
  }
  
  # Calculated extinction ratio
  proportions <- extinction_counts / total_simulations
  
  # Create data frame
  df <- data.frame(
    Initial_Condition = c("Adults Large", "Adults Small", "Mixed Large", "Mixed Small"),
    Extinction_Proportion = proportions
  )
  
  
  png(filename = "question_5.png", width = 600, height = 400)
  
  barplot(df$Extinction_Proportion, 
          names.arg = df$Initial_Condition, 
          col = "steelblue", 
          main = "Extinction Proportion by Initial Condition",
          xlab = "Initial Condition",
          ylab = "Proportion of Extinctions")
  
  Sys.sleep(0.1)  
  dev.off()
  
  # Find out which species are most at risk of extinction
  most_extinct <- df$Initial_Condition[which.max(df$Extinction_Proportion)]
  
  
  return(paste("The population with initial condition '", most_extinct, 
               "' was most likely to go extinct. This suggests that lower initial population sizes or weaker population structures increase extinction risk.", sep = ""))
}



# Question 6
question_6 <- function() {
  library(ggplot2)
  
  # projection_matrix
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
  
  projection_matrix <- reproduction_matrix + growth_matrix  # calculate projection_matrix
  
  # Get all RData files that store simulation results
  data_files <- list.files(pattern = "results_iter_.*\\.RData$")
  
  if (length(data_files) == 0) {
    stop("No simulation data found. Ensure the RData files are in the working directory.")
  }
  
  # Read all simulation data
  all_data <- list()
  
  for (file in data_files) {
    load(file)  # Load the results list
    condition <- ifelse(grepl("_3", file), "big_spread", "small_spread")
    all_data[[condition]] <- append(all_data[[condition]], list(results))
  }
  # Calculate average population size
  compute_mean_population <- function(results_list) {
    num_simulations <- length(results_list)
    simulation_length <- length(results_list[[1]])
    population_trend <- matrix(0, nrow = simulation_length, ncol = num_simulations)
    
    for (i in 1:num_simulations) {
      population_trend[, i] <- sapply(results_list[[i]], sum)
    }
    
    return(rowMeans(population_trend))
  }
  
  mean_pop_IC3 <- compute_mean_population(all_data$big_spread)
  mean_pop_IC4 <- compute_mean_population(all_data$small_spread)
  
  # Compute deterministic models
  deterministic_simulation <- function(initial_state, projection_matrix, steps) {
    pop_size <- numeric(steps)
    pop_size[1] <- sum(initial_state)
    
    for (t in 2:steps) {
      initial_state <- projection_matrix %*% initial_state
      pop_size[t] <- sum(initial_state)
    }
    
    return(pop_size)
  }
  
  deterministic_IC3 <- deterministic_simulation(c(25, 25, 25, 25), projection_matrix, length(mean_pop_IC3))
  deterministic_IC4 <- deterministic_simulation(c(2.5, 2.5, 2.5, 2.5), projection_matrix, length(mean_pop_IC4))
  
  #  drift compute
  deviation_data <- data.frame(
    Time = 1:length(mean_pop_IC3),
    Deviation_IC3 = mean_pop_IC3 / deterministic_IC3,
    Deviation_IC4 = mean_pop_IC4 / deterministic_IC4
  )
  
  # plot
  plot <- ggplot(deviation_data, aes(x = Time)) +
    geom_line(aes(y = Deviation_IC3, color = "Initial Condition 3 (big spread)")) +
    geom_line(aes(y = Deviation_IC4, color = "Initial Condition 4 (small spread)")) +
    labs(
      title = "Deviation of Stochastic Model from Deterministic Model",
      x = "Time",
      y = "Deviation (Stochastic / Deterministic)",
      color = "Initial Condition"
    ) +
    theme_minimal()
  
  ggsave("question_6.png", plot, width = 6, height = 4, dpi = 300)
  
  return("For initial condition 3 (big spread), the deterministic model is more appropriate because larger initial populations reduce the effects of stochasticity. In contrast, for initial condition 4 (small spread), stochastic effects are more pronounced, leading to greater deviations from the deterministic model.")
}


# Section Two: Individual-based ecological neutral theory simulation 


# Question 7
species_richness <- function(community){
  richness=length(unique(community))
  return(richness)
}
# Question 8
init_community_max <- function(size){
  max_species = seq_len(size)
  return(max_species)
}

# Question 9
init_community_min <- function(size){
  min_species = rep(1,size)
  return(min_species)
}

# Question 10
choose_two <- function(max_value){
  sample(1:max_value, 2)
}

# Question 11
neutral_step <- function(community){
  # Use choose_two to pick two distinct indices from the community vector.
  inds <- choose_two(length(community))
  
  # The first index is the individual to die.
  # The second index is the individual that reproduces.
  community[inds[1]] <- community[inds[2]]
  
  # Return the updated community.
  return(community)
}

# Question 12
neutral_generation <- function(community){
  # Get the number of individuals in the community
  n <- length(community)
  
  # Determine the number of neutral steps required for a generation
  # If n is even, then steps = n/2; If n is odd, randomly select floor(n/2) or ceiling(n/2)
  if (n %% 2 == 0) {
    steps <- n / 2
  } else {
    steps <- sample(c(floor(n / 2), ceiling(n / 2)), 1)
  }
  
  # Perform multiple neutral steps to simulate a generational change
  for (i in 1:steps) {
    community <- neutral_step(community)
  }
  
  # Return to the state of the community after a generation
  return(community)
}

# Question 13
neutral_time_series <- function(community,duration)  {
  # Initialize a vector to store species richness over time.
  # We store the initial richness plus one value per generation.
  richness_series <- numeric(duration + 1)
  
  # Record species richness of the initial community.
  richness_series[1] <- length(unique(community))
  
  # Loop over the number of generations.
  for (i in 1:duration) {
    # Update the community by one generation.
    community <- neutral_generation(community)
    # Record the species richness (number of unique species).
    richness_series[i + 1] <- length(unique(community))
  }
  
  # Return the time series vector.
  return(richness_series)
}

# Question 14
question_14 <- function() {
  # Initialize the community with maximum diversity:
  # Each of the 100 individuals represents a unique species.
  community <- init_community_max(100)
  
  # Run the neutral model simulation for 200 generations.
  # The function neutral_time_series returns a time series vector of species richness,
  # starting from the initial condition.
  richness_ts <- neutral_time_series(community, duration = 200)
  
  
  png(filename="question_14.png", width = 600, height = 400)
  # plot your graph here
  plot(richness_ts, type = "l",
       xlab = "Generation",
       ylab = "Species Richness",
       main = "Neutral Model Simulation: Species Richness Over Generations")
  Sys.sleep(0.1)
  dev.off()
  # Return the answer to the question in plain text.
  answer <- "The system will eventually converge to monodominance (species richness of 1). This is because in a neutral model without speciation, random drift eventually leads to the extinction of all species except one, resulting in an absorbing state."
  return(answer)
}

# Question 15
neutral_step_speciation <- function(community,speciation_rate)  {
  # Use choose_two to randomly pick two distinct indices in the community.
  inds <- choose_two(length(community))
  
  # The first index is the individual that dies.
  # The second index is used for reproduction if speciation does not occur.
  death_index <- inds[1]
  repro_index <- inds[2]
  
  # Generate a random number to decide whether speciation occurs.
  if (runif(1) < speciation_rate) {
    # SPECATION EVENT:
    # Determine a new species number that is not present in the current community.
    # One simple method is to take the maximum current species number and add 1.
    new_species <- max(community) + 1
    community[death_index] <- new_species
  } else {
    # REPRODUCTION EVENT (as in neutral_step):
    # Replace the dead individual with the offspring of the reproducing individual.
    community[death_index] <- community[repro_index]
  }
  
  # Return the updated community vector.
  return(community)
}

# Question 16
neutral_generation_speciation <- function(community,speciation_rate)  {
  # Get the number of individuals in the community.
  n <- length(community)
  
  # Determine the number of neutral steps (birth-death events) to constitute one generation.
  # If n is even, then n/2 steps represent one generation.
  # If n is odd, randomly choose between floor(n/2) and ceiling(n/2).
  if (n %% 2 == 0) {
    steps <- n / 2
  } else {
    steps <- sample(c(floor(n / 2), ceiling(n / 2)), 1)
  }
  
  # Perform the simulation steps using the speciation rule.
  # For each step, use neutral_step_speciation to update the community.
  for (i in 1:steps) {
    community <- neutral_step_speciation(community, speciation_rate)
  }
  
  # Return the updated community after one generation.
  return(community) 
}

# Question 17
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
  # Initialize a vector to store species richness for each generation.
  # The vector has length duration + 1 to include the initial condition.
  richness_series <- numeric(duration + 1)
  
  # Record the species richness of the initial community.
  richness_series[1] <- length(unique(community))
  
  # Loop over each generation.
  for (i in 1:duration) {
    # Advance the community one generation using the neutral model with speciation.
    community <- neutral_generation_speciation(community, speciation_rate)
    
    # Record the species richness (number of unique species) after this generation.
    richness_series[i + 1] <- length(unique(community))
  }
  
  # Return the time series vector of species richness.
  return(richness_series)
}

# Question 18
question_18 <- function() {
  
  png(filename = "question_18.png", width = 600, height = 400)
  
  # plot
  community_size <- 100
  speciation_rate <- 0.1
  duration <- 200
  
  community_max <- init_community_max(community_size)
  community_min <- init_community_min(community_size)
  
  richness_max <- neutral_time_series_speciation(community_max, speciation_rate, duration)
  richness_min <- neutral_time_series_speciation(community_min, speciation_rate, duration)
  
  plot(richness_max, type = "l", col = "red", lwd = 2,
       xlab = "Generation", ylab = "Species Richness",
       main = "Neutral Model Simulation with Speciation")
  
  lines(richness_min, type = "l", col = "blue", lwd = 2)
  
  legend("topright", legend = c("Max Diversity", "Min Diversity"),
         col = c("red", "blue"), lwd = 2)
  
  Sys.sleep(0.1)
  dev.off()
  
  return("The plot demonstrates that regardless of whether the simulation starts with maximal or minimal diversity, the neutral model with speciation converges to a similar dynamic equilibrium in species richness over time. This occurs because the stochastic processes of random drift and speciation eventually override the influence of the initial conditions, leading to a characteristic equilibrium state.")
}


# Question 19
  species_abundance <- function(community) {
    abundances <- table(community) 
    return(sort(as.numeric(abundances), decreasing = TRUE))
  }

# Question 20
  octaves <- function(abundance_vector) {
    if (length(abundance_vector) == 0) {
      return(numeric(0)) # Returns an empty value vector
    }
    
    octave_classes <- floor(log2(abundance_vector)) + 1
    octave_counts <- tabulate(octave_classes)
    
    return(octave_counts)
  }

# Question 21
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

# Question 22
question_22 <- function() {
  # Simulation parameters
  community_size <- 100
  speciation_rate <- 0.1
  burn_in <- 200
  duration <- 2000
  interval <- 20  # Record every 20 generations
  
  # Initialize communities
  community_max <- init_community_max(community_size)
  community_min <- init_community_min(community_size)
  
  # Burn-in phase
  for (i in 1:burn_in) {
    community_max <- neutral_generation_speciation(community_max, speciation_rate)
    community_min <- neutral_generation_speciation(community_min, speciation_rate)
  }
  
  # Initialize lists to store octave vectors
  octaves_max <- list()
  octaves_min <- list()
  
  # Main simulation loop (2000 generations)
  for (i in 1:duration) {
    community_max <- neutral_generation_speciation(community_max, speciation_rate)
    community_min <- neutral_generation_speciation(community_min, speciation_rate)
    
    # Every 20 generations, record species abundance octaves
    if (i %% interval == 0) {
      octaves_max[[length(octaves_max) + 1]] <- octaves(species_abundance(community_max))
      octaves_min[[length(octaves_min) + 1]] <- octaves(species_abundance(community_min))
    }
  }
  
  # Compute mean abundance octaves
  mean_octave_max <- Reduce(sum_vect, octaves_max) / length(octaves_max)
  mean_octave_min <- Reduce(sum_vect, octaves_min) / length(octaves_min)
  
  # Plot results
  png(filename="question_22.png", width = 600, height = 400)
  par(mfrow = c(1, 2))  # Split plot area into two panels
  
  barplot(mean_octave_max, col = "red", main = "Max Diversity Init", 
          xlab = "Octave", ylab = "Mean Abundance")
  barplot(mean_octave_min, col = "blue", main = "Min Diversity Init", 
          xlab = "Octave", ylab = "Mean Abundance")
  Sys.sleep(0.1)
  dev.off()
  
  return("The initial condition of the system does not significantly affect the long-term species abundance distribution. Over time, random drift and speciation drive the system towards a characteristic equilibrium state, where the species abundance follows a stable distribution regardless of the initial configuration.")
}


# Question 23
neutral_cluster_run <- function(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name) {
  # Initialize community with minimal diversity
  community <- init_community_min(size)
  
  # Start the timer
  start_time <- proc.time()[3]
  
  # Initialize storage vectors
  time_series <- numeric()
  abundance_list <- list()
  
  generation <- 0
  
  while ((proc.time()[3] - start_time) < (wall_time * 60)) {  # Convert minutes to seconds
    
    # Perform one generation step
    community <- neutral_generation_speciation(community, speciation_rate)
    generation <- generation + 1
    
    # Record species richness during burn-in phase
    if (generation <= burn_in_generations && generation %% interval_rich == 0) {
      time_series <- c(time_series, species_richness(community))
    }
    
    # Record species abundance in octaves every interval_oct generations
    if (generation %% interval_oct == 0) {
      abundance_list[[length(abundance_list) + 1]] <- octaves(species_abundance(community))
    }
  }
  
  # Capture the final elapsed time
  total_time <- proc.time()[3] - start_time
  
  # Save results to file
  save(time_series, abundance_list, community, total_time, 
       speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, 
       file = output_file_name)
}
# Questions 24 and 25 involve writing code elsewhere to run your simulations on
# the cluster

# Question 26 

process_neutral_cluster_results <- function() {
  files <- list.files(pattern = "neutral_output_.*\\.rda")  # Read the data file
  sizes <- c(500, 1000, 2500, 5000)  # 4 community sizes
  combined_results <- list("500" = NULL, "1000" = NULL, "2500" = NULL, "5000" = NULL)
  
  for (file in files) {
    load(file)  
    
    # Ensure abundance_list and size exist 
    if (exists("abundance_list") && exists("size")) {
      size_key <- as.character(size)  
      
      if (size_key %in% names(combined_results)) {
        combined_results[[size_key]] <- append(combined_results[[size_key]], abundance_list)
      } else {
        warning(paste("Unknown community size in file:", file))
      }
    } else {
      warning(paste("Warning: No abundance_list or size in", file))
    }
  }
  
  # calculate mean
  for (size in sizes) {
    size_key <- as.character(size)
    
    if (!is.null(combined_results[[size_key]]) && length(combined_results[[size_key]]) > 0) {
      combined_results[[size_key]] <- Reduce("+", combined_results[[size_key]]) / length(combined_results[[size_key]])
    } else {
      combined_results[[size_key]] <- numeric(0)  # Set to empty vector, not NA
    }
  }
  
  save(combined_results, file = "combined_results.rda")
  print("Processing complete. Results saved in combined_results.rda.")
}

# Function to load processed results and plot bar graphs
plot_neutral_cluster_results <- function() {
  # Load the calculated mean data
  if (!file.exists("combined_results.rda")) {
    stop("Error: combined_results.rda file not found. Run process_neutral_cluster_results() first.")
  }
  
  load("combined_results.rda")
  
  if (!exists("combined_results")) {
    stop("Error: combined_results object could not be loaded.")
  }
  
  
  png(filename = "plot_neutral_cluster_results.png", width = 600, height = 400)
  par(mfrow = c(2, 2))  
  
  sizes <- c(500, 1000, 2500, 5000)
  
  # Iterate over each community size and plot barplot
  for (size in sizes) {
    mean_abundance <- combined_results[[as.character(size)]]
    
    if (is.null(mean_abundance) || length(mean_abundance) == 0) {
      plot.new()
      text(0.5, 0.5, paste("No Data for size", size))
      next  # Skip this loop to avoid barplot errors
    }
    
    barplot(mean_abundance, main = paste("Community Size:", size),
            xlab = "Abundance Octave", ylab = "Mean Species Abundance",
            col = "blue", border = "black")
  }
  
  dev.off()
  
  print("Plotting complete. Figure saved as plot_neutral_cluster_results.png")
  
  return(combined_results)
}



# Challenge questions - these are substantially harder and worth fewer marks.
# I suggest you only attempt these if you've done all the main questions. 

# Challenge question A
Challenge_A <- function() {
  # Load required library
  library(ggplot2)
  
  # Get all simulation result files
  data_files <- list.files(pattern = "results_iter_.*\\.RData$")
  
  if (length(data_files) == 0) {
    stop("No simulation data found. Ensure the RData files are in the working directory.")
  }
  
  # Initialize a list to store all data
  all_data <- list()
  
  # Parse all simulation results
  simulation_counter <- 1  # Unique identifier for each simulation
  for (file in data_files) {
    load(file)  # Load the results list
    
    # Determine the initial condition based on the file name or a known variable
    if (grepl("_1", file)) {
      initial_condition <- "large_adult"
    } else if (grepl("_2", file)) {
      initial_condition <- "small_adult"
    } else if (grepl("_3", file)) {
      initial_condition <- "large_mixed"
    } else {
      initial_condition <- "small_mixed"
    }
    
    # Process `results` variable: each simulation contains 150 runs, each with 120 time steps
    for (sim in 1:length(results)) {
      sim_data <- data.frame(
        simulation_number = simulation_counter,
        initial_condition = initial_condition,
        time_step = 0:(length(results[[sim]]) - 1),  # Time steps start from 0
        population_size = sapply(results[[sim]], sum)  # Compute total population size at each time step
      )
      all_data[[length(all_data) + 1]] <- sim_data
      simulation_counter <- simulation_counter + 1
    }
  }
  
  # Combine all data into a single dataframe
  population_size_df <- do.call(rbind, all_data)
  
  # Optional: Limit data size to prevent overcrowding in the plot (uncomment to enable)
  # population_size_df <- population_size_df[sample(nrow(population_size_df), size = min(10000, nrow(population_size_df))), ]
  
  # Generate the optimized plot
  plot <- ggplot(population_size_df, aes(x = time_step, y = population_size, 
                                         group = simulation_number, colour = initial_condition)) +
    geom_line(alpha = 0.05) +  # Reduce transparency to avoid excessive overlapping
    facet_wrap(~initial_condition) +  # Separate plots for each initial condition
    labs(title = "Stochastic Simulation of Population Size",
         x = "Time Step",
         y = "Population Size",
         colour = "Initial Condition") +
    theme_bw() +  # Use a white background for better readability
    theme(legend.position = "bottom")  # Move the legend to the bottom
  
  # Save the plot
  ggsave("Challenge_A.png", plot, width = 8, height = 6, dpi = 300)
  
  # Return the processed data frame
  return(population_size_df)
}

# Challenge question B
Challenge_B <- function() {
  
  png(filename="Challenge_B.png", width = 600, height = 400)
  
  # Function to calculate confidence intervals
  compute_confidence_interval <- function(data, confidence = 0.972) {
    mean_values <- colMeans(data)
    sem <- apply(data, 2, function(x) sd(x) / sqrt(length(x)))
    ci_range <- qt((1 + confidence) / 2, df = nrow(data) - 1) * sem
    return(list(mean = mean_values, lower = mean_values - ci_range, upper = mean_values + ci_range))
  }
  
  # Simulation parameters
  community_size <- 100
  speciation_rate <- 0.1
  num_simulations <- 50
  duration <- 200
  
  # Store simulation results
  richness_max_simulations <- matrix(NA, nrow = num_simulations, ncol = duration)
  richness_min_simulations <- matrix(NA, nrow = num_simulations, ncol = duration)
  
  for (sim in 1:num_simulations) {
    community_max <- init_community_max(community_size) # Max diversity
    community_min <- init_community_min(community_size) # Min diversity
    
    for (gen in 1:duration) {
      community_max <- neutral_generation_speciation(community_max, speciation_rate)
      community_min <- neutral_generation_speciation(community_min, speciation_rate)
      
      richness_max_simulations[sim, gen] <- species_richness(community_max)
      richness_min_simulations[sim, gen] <- species_richness(community_min)
    }
  }
  
  # Compute mean and confidence intervals
  ci_max <- compute_confidence_interval(richness_max_simulations)
  ci_min <- compute_confidence_interval(richness_min_simulations)
  
  # Estimate equilibrium time: when richness change over last 20 generations is <1%
  equilibrium_max <- min(which(abs(diff(ci_max$mean[(duration - 20):duration])) < 0.01 * ci_max$mean[duration - 20]))
  equilibrium_min <- min(which(abs(diff(ci_min$mean[(duration - 20):duration])) < 0.01 * ci_min$mean[duration - 20]))
  
  equilibrium_gen <- max(ifelse(is.finite(equilibrium_max), equilibrium_max, duration),
                         ifelse(is.finite(equilibrium_min), equilibrium_min, duration))
  
  # Plot results
  plot(
    1:duration, ci_max$mean, type="l", col="red", lwd=2,
    xlab="Generations", ylab="Species Richness",
    main="Species Richness Over Generations with 97.2% CI"
  )
  lines(1:duration, ci_min$mean, col="blue", lwd=2)
  
  polygon(
    c(1:duration, rev(1:duration)),
    c(ci_max$upper, rev(ci_max$lower)),
    col=rgb(1,0,0,0.2), border=NA
  )
  
  polygon(
    c(1:duration, rev(1:duration)),
    c(ci_min$upper, rev(ci_min$lower)),
    col=rgb(0,0,1,0.2), border=NA
  )
  
  abline(v=equilibrium_gen, lty=2, col="black")
  legend("topright", legend=c("Max Diversity", "Min Diversity"),
         col=c("red", "blue"), lwd=2)
  
  
  dev.off()
  
  # Return equilibrium estimate
  return(paste("The system reaches dynamic equilibrium in approximately", equilibrium_gen, "generations."))
}

# Challenge question C
Challenge_C <- function() {
  # Ensure correct filename format
  png(filename="Challenge_C.png", width = 600, height = 400)
  
  # Define a function to create a random community with specific initial species richness
  # Each individual has equal probability of taking any species identity
  init_community_random <- function(size, species_count) {
    # Ensure species count does not exceed community size
    species_count <- min(species_count, size)
    # Randomly select 'size' individuals from species IDs 1 to species_count, allowing repetition
    community <- sample(1:species_count, size, replace = TRUE)
    return(community)
  }
  
  # Function to calculate confidence intervals
  compute_confidence_interval <- function(data, confidence = 0.95) {
    mean_values <- colMeans(data)
    sem <- apply(data, 2, function(x) sd(x) / sqrt(length(x)))
    ci_range <- qt((1 + confidence) / 2, df = nrow(data) - 1) * sem
    return(list(mean = mean_values, lower = mean_values - ci_range, upper = mean_values + ci_range))
  }
  
  # Simulation parameters
  community_size <- 100
  speciation_rate <- 0.1
  num_simulations <- 30
  duration <- 200
  
  # Define the range of initial species richness values to test
  # From 1 to community_size, selecting representative values
  initial_richness_values <- c(1, 5, 10, 25, 50, 75, 100)
  
  # Create a color for each initial richness value
  colors <- rainbow(length(initial_richness_values))
  
  # Initialize the plot
  plot(NULL, xlim=c(1, duration), ylim=c(0, 50), 
       xlab="Generations", ylab="Species Richness",
       main="Species Richness Over Time for Different Initial Richness Values")
  
  # Prepare text for legend
  legend_text <- character(length(initial_richness_values))
  
  # Run simulations for each initial richness value
  for (i in 1:length(initial_richness_values)) {
    richness_value <- initial_richness_values[i]
    legend_text[i] <- paste("Initial Richness:", richness_value)
    
    # Store simulation results
    richness_simulations <- matrix(NA, nrow = num_simulations, ncol = duration)
    
    # Run multiple simulations
    for (sim in 1:num_simulations) {
      # Create a random community with specific initial richness
      community <- init_community_random(community_size, richness_value)
      
      # Record species richness for each generation
      for (gen in 1:duration) {
        community <- neutral_generation_speciation(community, speciation_rate)
        richness_simulations[sim, gen] <- species_richness(community)
      }
    }
    
    # Calculate means and confidence intervals
    ci <- compute_confidence_interval(richness_simulations)
    
    # Plot the mean line
    lines(1:duration, ci$mean, col=colors[i], lwd=2)
    
    # Add confidence intervals
    polygon(
      c(1:duration, rev(1:duration)),
      c(ci$upper, rev(ci$lower)),
      col=adjustcolor(colors[i], alpha.f=0.2), border=NA
    )
  }
  
  # Add legend
  legend("topright", legend=legend_text, col=colors, lwd=2, cex=0.8)
  
  # Ensure graphics device is closed
  dev.off()
  
  # Return result
  return("Graph showing species richness over time for different initial richness values has been saved as Challenge_C.png")
}

# Challenge question D
Challenge_D <- function() {
  if (!file.exists("combined_results.rda")) {
    stop("Error: combined_results.rda file not found.")
  }
  
  load("combined_results.rda")  # Load the processed data
  
  # Make sure combined_results exists
  if (!exists("combined_results")) {
    stop("Error: combined_results not found in the loaded file.")
  }
  
  colors <- c("500" = "red", "1000" = "blue", "2500" = "green", "5000" = "purple")
  
  # Open the PNG device and save the drawing
  png(filename = "Challenge_D.png", width = 600, height = 400)
  
  # Set the drawing range
  plot(NA, NA, xlim = c(1, length(combined_results[["500"]])), 
       ylim = c(0, max(sapply(combined_results, max, na.rm = TRUE))), 
       xlab = "Simulation Generation", ylab = "Mean Species Richness",
       main = "Mean Species Richness vs Simulation Generation")
  
  # Traverse different sizes and draw curves
  for (size in names(combined_results)) {
    if (length(combined_results[[size]]) > 0) {
      lines(1:length(combined_results[[size]]), combined_results[[size]], 
            col = colors[[size]], lwd = 2, type = "l")
    }
  }
  
  legend("bottomright", legend = names(colors), col = colors, lty = 1, lwd = 2, title = "Community Size")
  Sys.sleep(0.1)
  dev.off()
  
  print("Challenge_D.png has been saved.")
}


# Challenge question E
Challenge_E <- function(J, speciation_rate) {
  # Initialize variables
  lineages <- as.list(rep(1, J))  # Replace vector with list
  abundances <- c()  # Record species abundance
  N <- J  # Number of current independent lineages
  theta <- speciation_rate * (J - 1) / (1 - speciation_rate)  # Calculate θ
  
  # Record common ancestor simulation run time
  time_coalescence <- system.time({
    while (N > 1) {
      j <- sample(seq_along(lineages), 1)  # Randomly select a lineage
      randnum <- runif(1)  # Generate random numbers between 0 and 1
      
      if (randnum < theta / (theta + N - 1)) {
        abundances <- c(abundances, as.numeric(lineages[[j]]))  
        lineages[[j]] <- NULL  
      } else {
        # Species amalgamation
        lineages <- Filter(Negate(is.null), lineages)  
        remaining_indices <- seq_along(lineages)  # reindex
        i <- sample(setdiff(remaining_indices, j), 1)
        
        # Fix: Make sure i and j are single values
        lineages[[i]] <- sum(as.numeric(lineages[[i]]), as.numeric(lineages[[j]]))
        lineages[[j]] <- NULL  
      }
      
      
      lineages <- Filter(Negate(is.null), lineages)
      N <- length(lineages)
    }
    
    # Add the last element to the abundances at the end
    abundances <- c(abundances, unlist(lineages))  # Make sure it's a value
  })[3]
  
  # Record the forward simulation run time
  time_forward <- system.time({
    process_neutral_cluster_results()
  })[3]
  
  # plot
  png(filename="Challenge_E.png", width = 600, height = 400)
  barplot(sort(abundances, decreasing = TRUE), 
          main = "Species Abundances from Coalescence Simulation",
          xlab = "Species Rank", ylab = "Abundance", col = "blue")
  Sys.sleep(0.1)
  dev.off()
  
  # Return CPU time comparison & explanation
  return(paste(
    "Coalescence simulation CPU time:", round(time_coalescence, 3), "seconds.",
    "\nForward-time simulation CPU time:", round(time_forward, 3), "seconds.",
    "\nWhy is coalescence faster?",
    "\nCoalescence simulation traces lineages backward to their most recent common ancestor.",
    "\nThis method does not require tracking each individual’s fate, reducing computational steps.",
    "\nIn contrast, forward-time simulations update each individual in every generation, making them much slower."
  ))
}

# Challenge_E(J = 100, speciation_rate = 0.01)
