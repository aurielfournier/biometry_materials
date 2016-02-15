# Biometry 2016 
# Lab 5
# One Way ANOVA


# packages you will need
library(ggplot2)
library(ggthemes)

dat <- read.csv("./20160218_biometry_lab_5_one_way_anova/microhabitat.csv")

# What is the factor
str(dat)

# How many levels of the factor
unique(dat$HABITAT)

# How do the data look?
summary(dat)
str(dat)
head(dat)

# check the assumptions

# normality
ggplot()+
  geom_boxplot(data=dat, aes(y=VELOCITY, x=1))+
  theme_few()+
  coord_flip()

ggplot()+
  geom_histogram(data=dat, aes(x=VELOCITY))+
  theme_few()

# homogeneity of variance
ggplot()+geom_boxplot(data=dat, aes(x=SITE, y=VELOCITY))+theme_few()

# independence



### To perform an ANOVA you use the aov() function.

# You use the data= argument to give it the data object (in this example, dat)
# then you put your response on the left side and your predictor on the right side of the tilda (~) (found above above the tab key)
model <- aov(data=dat, VELOCITY ~ SITE)
# you can also do anova(model) but summary gives you the same information and summary() can be used on other model types
(modeltable <- summary(model)) # by putting the entire function and output in parentheses it will save the modeltable to 'modeltable' and also print it to the console



###
# Excercise
###

# Can you read and interpret the ANOVA table?
# Could you explain it to me?
# Are there significant differences among SITES?

# Which SITES are different from each other?
# How would you go about answering this question?
# Again could you explain to me?
# What is the difference between experiment-wise error and pairwise error?
# Have you controlled the experiment-wise error level?
# What is the difference between an a-posteriori test and a a-priori test?
# Which are you doing? 

#### Now do the same thing with velocity with your variable of interest

# how do the data look?
# Does the data mean the assumptions of the test?
# Why, or why not?
# Once you've done all that you know the data are not normally distributed for Velocity, so let's try a non-parametric test that is equivelent to the ANOVA?
# What test would you use? 
# Are there any assumptions?
# Does your data meet the assumptions?
# Try to get your data to meet the assumptions then do the test.
# Can you interpret the results?
