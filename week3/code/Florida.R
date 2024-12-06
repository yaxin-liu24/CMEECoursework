rm(list=ls())
load("../data/KeyWestAnnualMeanTemperature.RData")
ls()
# calculate the appropriate correlation coefficients
appropriate_corr <- cor(ats$Year, ats$Temp)
print(paste("Appropriate Correlation is:", appropriate_corr))

set.seed(123) # make sure the results are repeatable
n <- 5000     # repeat number of times
random_corrs <- numeric(n) # create an empty vector to hold the random correlation coefficients # nolint

for (i in 1:n) {
  shuffled_temp <- sample(ats$Temp) # randomly disturbance temperature
  random_corrs[i] <- cor(ats$Year, shuffled_temp) #calculate correlation coefficients # nolint
}

# calculate p value
p_value <- mean(random_corrs >= appropriate_corr)
print(paste("P-value:", p_value))

# visualize the random distribution
# hist(random_corrs, main = "Random Correlation Coefficients", xlab = "Correlation") # nolint
# abline(v = appropriate_corr, col = "red", lwd = 2) #mark the observed correlation coefficients # nolint
## set output as PDF，save to ../results 
pdf("../results/Florida.pdf", width = 8, height = 6) 
# draw histgram
hist(random_corrs, main = "Random Correlation Coefficients", xlab = "Correlation", col = "lightblue",border = "white") 
abline(v = appropriate_corr, col = "red", lwd = 2)  
dev.off()

# print the results
if (p_value < 0.05) {
  print("The appropriate correlation is statistically significant.")
} else {
  print("The appropriate correlation is not statistically significant.")
}
