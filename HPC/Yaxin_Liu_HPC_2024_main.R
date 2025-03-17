# CMEE 2024 HPC exercises R code main pro forma
# You don't HAVE to use this but it will be very helpful.
# If you opt to write everything yourself from scratch please ensure you use
# EXACTLY the same function and parameter names and beware that you may lose
# marks if it doesn't work properly because of not using the pro-forma.

name <- "Your Name"
preferred_name <- "Name"
email <- "abc123@imperial.ac.uk"
username <- "abc123"

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
  # 打开绘图设备
  library(ggplot2)
  
  # 创建数据框
  time_steps <- 0:simulation_length
  data <- data.frame(
    Time = rep(time_steps, 2),
    Population = c(population_1, population_2),
    Condition = rep(c("All Adults", "Even Distribution"), each = length(time_steps))
  )
  
  # 强行展示图表
  dev.new()  # 打开一个新的图形设备（RStudio 或操作系统支持的设备）
  p <- ggplot(data, aes(x = Time, y = Population, color = Condition)) +
    geom_line(size = 1) +  # 绘制线条
    labs(
      title = "Population Dynamics: Two Initial Conditions",
      x = "Time (Steps)",
      y = "Total Population Size",
      color = "Initial Condition"  # 图例标题
    ) +
    theme_minimal() +  # 设置主题
    theme(
      plot.title = element_text(hjust = 0.5, size = 14),  # 标题居中
      legend.position = "top"  # 图例放在顶部
    )
  print(p)
  

  
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
question_2

# Questions 3 and 4 involve writing code elsewhere to run your simulations on the cluster


# Question 5
question_5 <- function(){
  
  png(filename="question_5", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

# Question 6
question_6 <- function(){
  
  png(filename="question_6", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
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
  # 获取社区中个体的数量
  n <- length(community)
  
  # 确定一个世代所需的中性步骤次数
  # 如果 n 为偶数，则 steps = n/2；如果 n 为奇数，则随机选择 floor(n/2) 或 ceiling(n/2)
  if (n %% 2 == 0) {
    steps <- n / 2
  } else {
    steps <- sample(c(floor(n / 2), ceiling(n / 2)), 1)
  }
  
  # 执行多个中性步骤来模拟一个世代的变化
  for (i in 1:steps) {
    community <- neutral_step(community)
  }
  
  # 返回经过一个世代后的社区状态
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
  
  
  png(filename="question_14", width = 600, height = 400)
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
  png(filename="question_18", width = 600, height = 400)
  # plot your graph here
  # Set simulation parameters
  community_size <- 100
  speciation_rate <- 0.1
  duration <- 200
  
  # Create two different initial communities:
  # - Maximal diversity: each individual is a unique species.
  community_max <- init_community_max(community_size)
  # - Minimal diversity: all individuals belong to the same species.
  community_min <- init_community_min(community_size)
  
  # Run the simulation with speciation for both initial conditions.
  # neutral_time_series_speciation returns a vector of species richness over generations.
  richness_max <- neutral_time_series_speciation(community_max, speciation_rate, duration)
  richness_min <- neutral_time_series_speciation(community_min, speciation_rate, duration)
  
  # Plot the time series for the maximal diversity initial condition in red.
  plot(richness_max, type = "l", col = "red", lwd = 2,
       xlab = "Generation", ylab = "Species Richness",
       main = "Neutral Model Simulation with Speciation")
  
  # Overlay the time series for the minimal diversity initial condition in blue.
  lines(richness_min, type = "l", col = "blue", lwd = 2)
  
  # Add a legend to differentiate the two curves.
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
      return(numeric(0)) # 返回空数值向量
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
  png(filename="question_22", width = 600, height = 400)
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
  
  
  combined_results <- list() #create your list output here to return
  # save results to an .rda file
  
}

plot_neutral_cluster_results <- function(){

    # load combined_results from your rda file
  
    png(filename="plot_neutral_cluster_results", width = 600, height = 400)
    # plot your graph here
    Sys.sleep(0.1)
    dev.off()
    
    return(combined_results)
}


# Challenge questions - these are substantially harder and worth fewer marks.
# I suggest you only attempt these if you've done all the main questions. 

# Challenge question A
Challenge_A <- function(){
  
  png(filename="Challenge_A", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
}

# Challenge question B
Challenge_B <- function() {
  
  png(filename="Challenge_B", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
}

# Challenge question C
Challenge_B <- function() {
  
  png(filename="Challenge_C", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()

}

# Challenge question D
Challenge_D <- function() {
  
  png(filename="Challenge_D", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
}

# Challenge question E
Challenge_E <- function() {
  
  png(filename="Challenge_E", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

