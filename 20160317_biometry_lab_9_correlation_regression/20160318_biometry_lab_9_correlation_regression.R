# Biometry 2016 
# Lab 9
# Correlation and Regression
library(ggplot2)
library(ggthemes)
library(ggfortify)
library(gridExtra)
# Using the data in "seasons.csv", answer the following questions.  

dat <- read.csv("./20160317_biometry_lab_9_correlation_regression/seasons.csv")

head(dat)

summary(dat)

str(dat)

# This file contains many abiotic and biotic variables that were collected in three different Ozark streams (see SITE).  
# The following questions pertain to correlation and regression on variables in this dataset.

#function for correlation
# cor(x, y = NULL, method = c("pearson", "kendall", "spearman"))

cor(dat$Area, dat$Cover, method="pearson")

# fuction for a regression
# lm(formula, data)

## Check Assumptions!

## Normality

ggplot()+
  geom_boxplot(data=dat, aes(y=Cover, x=1))+
  theme_few()+
  coord_flip()


## Homogeneity of Variance

ggplot()+
  geom_boxplot(data=dat, aes(y=Cover, x=1))+
  theme_few()+
  coord_flip()


## Independence


# running a linear regression
model <- lm(Area ~ Cover, data=dat)
summary(model)

## plotting the regression line
ggplot()+geom_smooth(data=dat, aes(x=Cover, y=Area), method="lm", color="black")+theme_few()


# examining the residuals
autoplot(model, which = 1:6, ncol = 3, label.size = 3)+theme_few() 


# If you were interested in determining the degree of association among the following variables (Area, Cover, Canopy, Depth, Substrate, Totdens, Richness), how would you do it?

# What is the difference between regression and correlation?  
# Does the data meet the assumptions of the test?  
# How can you tell?  
# What could you do if the data did not meet the assumptions?


# Carry out the appropriate test for the above data, assuming that they meet the assumptions of the test.  
# Which correlations are significant?  
# What does a significant correlation mean?  

# For example, explain what the relationship is between substrate and depth, and between richness and totdens.  

# Is there a problem with looking at so many tests (remember experimentwise and comparisonwise type I error rates)?


# What are the assumptions of linear regression?  
# I want to know if Totdens and Richness can be predicted by Volume. 

# Do the appropriate tests and report your results. 

# What do they mean?  

# Are the regressions significant?  

# What does a significant regression mean?  

# What are least squares?