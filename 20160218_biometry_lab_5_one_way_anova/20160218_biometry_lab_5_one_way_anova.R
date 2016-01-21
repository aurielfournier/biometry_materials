# Biometry 2016 
# Lab 4
# One Way ANOVA

# Packages You Need

dat <- read.csv("./20160218_biometry_lab_5_one_way_anova/microhabitat.csv")

# What is the factor
str(dat)

# How many levels of the factor
unique(dat$HABITAT)

# How do the data look?
summary(dat)
str(dat)
head(dat)

model <- aov(data=dat, VELOCITY ~ SITE)
modeltable <- summary(model)

# Can you read and interpret the ANOVA table?
# Could you explain it to me?
# Are there significant differences among SITES?

# Which SITES are differnt from each other?
# How would yuou go about answering this question?
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
# What teset would yo uuse? 
# Are there any assumptions?
# Does your data meet the assumptions?
# Try to get your data to meet the assumptions then do the test.
# Can you interpret the results?
