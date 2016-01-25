# Biometry 2016 
# Lab 10
# Multiple Linear Regression


# Open the file "sto_den.csv".  
# This file is based on a study in which I wished to examine the relationship between physical variables and the density of stonerollers (Campostoma anomalum). 
# Stonerollers are small minnows occurring abundantly in Arkansas streams.  
# I measured density of small fish (<80mm) and large fish (???80mm) separately. 
# I sampled fish density in pools and measured physical variables in those same pools.  


# Depth	Water = depth in cm
# Substrate	= Size of substrate from 1 (sand) to 6 (boulders)
# Conductivity =Measure of dissolved ions in the water
# HABCOV = Index of available cover
# DO =	Dissolved oxygen
# DENSIOM =	Measure of canopy openness
# MAXDEPTH =	Maximum pool depth

# Run a regression using all predictor variables against small stoneroller density. 
# Did you remember to check for the assumptions of the regression?  
# How do your residuals look?  
# What does the R2 value represent?  
# The adjusted R2?  
# How are they calculated?  
# What do the p values for the regression coefficients mean?  
# In the ANOVA table, what does the p-value mean?

# Open the file "Multiple Regression.csv".  
# These data are from exclusions of crayfish and fish in the Little Mulberry River.  
# BIOFILM is the size of the effect of fish and crayfish on stream algal communities (Positive numbers indicate grazing decreased biofilm, negative indicate increases due to grazing).  

# Perform a step-wise multiple regression predicting BIOFILM from the other variables.  
# Use a forward and backward selection procedure in the step-wise regression.  
# Compare the resulting models.  
# Are they similar?  
# Perform a manual iterative selection process by including all the independent variables, then removing the one with the largest p-value.  
# Continue until all p-values are <0.15.  
# How do p-values change after each iteration?  
# Slope coefficients?

# Return to "sto_den.csv".

#  Now I want to know which of the physical variables best explains the variation in density and how much variation the model explains overall.  
# First check for correlations among independent variables.  
# Select four candidate models and rank them according to AIC(corrected) values (smaller AIC = better/more parsimonious models).

# how to get AIC
# AIC(model)

# Also include the global model (which includes all variables included in the candidate models). 
# Do this separately for small and large fish, and then compare the two.  
# Which variables did you use in your model?  
# Why?  
# What does the AIC value take into account?  

# For your top model, can you write out the linear model with the beta coefficients?
