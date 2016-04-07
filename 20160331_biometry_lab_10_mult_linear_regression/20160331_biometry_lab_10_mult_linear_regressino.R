# Biometry 2016 
# Lab 10
# Multiple Linear Regression


# Open the file "sto_den.csv".  
# This file is based on a study in which we wished to examine the relationship between physical variables and the density of stonerollers (Campostoma anomalum). 
# Stonerollers are small minnows occurring abundantly in Arkansas streams.  
# We measured density of small fish (<80mm) and large fish (>80mm) separately. 
# We sampled fish density in pools and measured physical variables in those same pools.  

# POOL = the pool ID
# SITE = the stream name
# DEPTH = depth in cm
# SUBSTRAT	= Size of substrate from 1 (sand) to 6 (boulders)
# COND =Measure of dissolved ions in the water
# DO =	Dissolved oxygen
# HABCOV = Index of available cover
# DENSIOM =	Measure of canopy openness
# MAXDEPTH =	Maximum pool depth
# STO_SM_DEN = Density of small stonerollers
# STO_L_DEN = Density of large stonerollers


# Run a regression using all predictor variables against small stoneroller density. 
# example = lm(data=dat, RESPONSE ~ PREDICTOR1 + PREDICTOR2 + PREDICTOR3)


# What are the assumptions of multiple regression?
# how can we check for them?



# How do your residuals look?  


# What does the R2 value represent?  
# The adjusted R2?  
# How are they calculated?  
# What do the p values for the regression coefficients mean?  
# In the ANOVA table, what does the p-value mean?



# Open the file "multiple_regression.csv".  
# These data are from exclusions of crayfish and fish in the Little Mulberry River.  
# BIOFILM is the size of the effect of fish and crayfish on stream algal communities (Positive numbers indicate grazing decreased biofilm, negative indicate increases due to grazing).  

# Check assumptions


# Perform a step-wise multiple regression predicting BIOFILM from the other variables.  
# Use a forward and a backward selection procedure in the step-wise regression.  

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
# min(AIC(model1),AIC(model2),AIC(model3)) # this will give you the lowest AIC value

# Also include the global model (which includes all variables included in the candidate models). 

# Do this separately for small and large fish, and then compare the two.  

# Which variables did you use in your model?  

# Why?  

# What does the AIC value take into account?  

# For your top model, can you write out the linear model with the beta coefficients?
