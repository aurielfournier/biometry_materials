# Biometry 2016 
# Lab 10
# Multiple Linear Regression
# Filled in Script made by Auriel April 7 2016


### If you want to know what version of R you are using
R.version$version.string

### if you want the citation for your current version of R
citation()

### if you want the citation for a package
citation("packagenamehere")


######################################################

### Libraries
library(ggplot2) ### regular plotting with ggplot
library(ggfortify) ### this gives us autoplot
library(MASS) ### this will let us do stepwise regression in an automated fashion
library(ggthemes) # gives us theme_few()
library(car) # gives us durbin.watson()

# Open the file "sto_den.csv".  

### First set, set working directory
setwd("~/Biometry_Materials/20160331_biometry_lab_10_mult_linear_regression")
### Yours will probably be different

dat <- read.csv("sto_den.csv")

# make sure things are ready in correctly and there aren't any crazy values
head(dat)
str(dat)
summary(dat)

# This file is based on a study in which we wished to examine the relationship between physical variables and the density of stonerollers (Campostoma anomalum). 
# Stonerollers are small minnows occurring abundantly in Arkansas streams.  
# We measured density of small fish (<80mm) and large fish (>80mm) separately. 
# We sampled fish density in pools and measured physical variables in those same pools.  

# POOL = the pool ID
# SITE = the stream name
### ^ those two values are categories, we aren't interested in those

# SPNUM = species richness
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

model <- lm(data=dat, STO_SM_DEN ~ SPNUM + DEPTH + SUBSTRAT + COND + DO + HABCOV + DENSIOM + MAXDEPTH)
summary(model)
### ^ here we are interested in what coefficients are significant, and what our Multiple R-squared value is. 

### only Densiom is significant
### our Multiple R-Squared is 0.91 which is CRAZY GOOD


autoplot(model, which=1:6, ncol=3, label.size=3)
### arguments of autoplot
### model = the model that you got from lm() above
### which = the graphs that you want, you don't need to change this
### ncol = the number of columns, you don't need to change this 
### label.size = this makes the labels a bit bigger, you don't need to change this 


# What are the assumptions of multiple regression?

### Normality
### Homogeneity of Variance
### Independence

# how can we check for them?

### Normality - scatter plots can help, we can also look at the Normal Q-Q plot in the autoplot graph
### Homogeneity of variance - scatter plots, and sometimes box plots can help, but since we are dealing with continuous variables box plots are often unhelpful, the residuals vs fitted plot in autoplot is very helpful
### Independence - first set is to make sure that the experimental design is set up correctly. You can also run a Durbin's D test to test for independence and look for clumping or anti-clumping in scatter plots


### scatter plot in ggplot

ggplot()+geom_point(data=dat, aes(y=STO_SM_DEN, x=DEPTH))+theme_few() ### you want to look at each predictor variable independently vs the response. 

### Durbin Watson's D

durbinWatsonTest(model)

### big p value means that we are good to go. If we had a small p value we would have issues of independence 


# How do your residuals look?  
autoplot(model, which=1:6, ncol=3, label.size=3)
### second column, top graph



ss <- summary(model)
ss$r.squared ### r-squared
ss$adj.r.squared ### adjusted r-squared
ss$coefficients ### regression coefficients

# What does the R2 value represent?  

### it means how much variation is being explained by the data
### if your r^2 is 0.91 that means that your predictors are explaining 91% of the variation in your response variable. 

# The adjusted R2?  

### adjusted R squared is a method of ranking models, the actual value here is not important, you are just interested in if it is bigger or smaller then another model you are considering (like AIC)

# How are they calculated?  

### see your textbook

# What do the p values for the regression coefficients mean?  

### there is a p value for each predictor and that is telling you if you if the relationship for that covariate, is significantly different then zero. These relationships can change depending on the other predictors in the model. So if you are looking at the relationship with DO and you remove MAXDEPTH and rerun the model it could change. 

# In the ANOVA table, what does the p-value mean?

#### This value, the p value at the bottom of summary(model) is the significant of the entire model. This may or may not be of interest. Often its the p value of the predictors and the R^2 value that we are really interested in. 




#############
### Second Data Set
##############


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
