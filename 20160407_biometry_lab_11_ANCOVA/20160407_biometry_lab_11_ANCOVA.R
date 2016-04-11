# Biometry 2016 
# Lab 11
# ANCOVA


# Using the data in "partridge_ANCOVA.csv", answer the following questions.  
# The authors were interested in the effect of the number of mating partners (TREATMEN) on fruitfly longevity (LONGEV). Thorax length (THORAX), a measure of fruitfly size, was also measured and is used as a covariate. 

# If you wanted to determine whether the treatment had an effect on longevity, how would you do it? 

# ANCOVA IN R
# model=aov(response ~ covariate + factorvariable, data=object)


# Run an ANOVA on LONGEV and TREATMEN
# Does the data meet the assumptions of the test?  

## normality (scatterplot, Q-Q plot)

## homogeneity of variance (residuals plot)

## independence (exp design, Durbin-Watson D)

## linearity (scatterplots)

## covariate values similar across groups (boxplots)

## fixed covariate (is our factor fixed and measured with no error?)

# How can you tell?  

# What could you do if the data did not meet the assumptions?



#############
# Now do an ANCOVA using the covariate (THORAX) instead of TREATMEN.  

# Make sure you test the assumptions first (see above)

# What does the corresponding ANCOVA table tell you?  Interpret it for me.  

# What is a covariate and why bother with it? 
