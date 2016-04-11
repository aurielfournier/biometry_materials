# Biometry 2016 
# Lab 11
# ANCOVA

library(ggplot2)
library(ggthemes)
library(car) # gives us durbin.watson()

# Using the data in "partridge_ANCOVA.csv", answer the following questions.  
# The authors were interested in the effect of the number of mating partners (TREATMEN) on fruitfly longevity (LONGEV). Thorax length (THORAX), a measure of fruitfly size, was also measured and is used as a covariate. 

# If you wanted to determine whether the treatment had an effect on longevity, how would you do it? 

# ANCOVA IN R
# model <- aov(response ~ covariate + factorvariable, data=object)


dat <- read.csv("partridge_ancova.csv")

# Run an ANOVA on LONGEV and TREATMEN
# Does the data meet the assumptions of the test?  

## normality 

dat$TREATMEN <- as.factor(dat$TREATMEN)

ggplot()+geom_histogram(data=dat, aes(x=LONGEV))+facet_wrap(~TREATMEN)+theme_few()

## homogeneity of variance 

dat$TREATMEN <- as.factor(dat$TREATMEN)

ggplot()+geom_boxplot(data=dat, aes(y=LONGEV, x=TREATMEN, group=TREATMEN))+theme_few()+coord_flip()


## independence (exp design)

### we don't know anything about the experimental design, so we have to assume that things are OK


# How can you tell?  

# What could you do if the data did not meet the assumptions?


model <- aov(data=dat, LONGEV ~ TREATMEN)
summary(model)



#############
# Now do an ANCOVA using the covariate (THORAX) instead of TREATMEN.  

# Make sure you test the assumptions first (see above)

## linearity (scatterplots)

ggplot()+geom_point(data=dat, aes(y=LONGEV, x=THORAX))+theme_few()+facet_wrap(~TREATMEN)

## covariate values similar across groups (boxplots)

ggplot()+geom_boxplot(data=dat, aes(y=THORAX, x=TREATMEN, group=TREATMEN))+theme_few()+coord_flip()

### also look at our ANOVA results from above

## fixed covariate (is our factor fixed and measured with no error?)

### well is it? hmmmm????


model <- aov(data=dat, LONGEV ~ TREATMEN + THORAX)
summary(model)

# What does the corresponding ANCOVA table tell you?  Interpret it for me.  

# What is a covariate and why bother with it? 
