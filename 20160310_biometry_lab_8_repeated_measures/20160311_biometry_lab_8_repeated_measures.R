# Biometry 2016 
# Lab 8
# Repeated Measures and Randomized Block ANOVA

# packages you need
library(tidyr)

#Use the data in "ben.csv". 

ben <- read.csv('./20160311_biometry_lab_8_repeated_measures/ben.csv')
summary(ben)
str(ben)
head(ben)

# This file contains data from a study examining effects of crayfish on various ecosystem responses including levels of silt, detritus, chlorophyll a (measure of algal growth) and invertebrate density.  
# I have included the publication that used this data to provide background on the study and methods used.  The study used a manipulative field experiment with a blocking and repeated measures design.  
# The treatments were no crayfish (n), small crayfish (s) and large crayfish (l). 

# We wanted to know whether crayfish treatment affected response variables and whether this changed over time.  
# I come to you as my friendly neighborhood statistician and ask you to tell me the answer. 
# What do you say?  

# randomized block w/o the repeated measures
# model <- aov(response ~ treatment + block, data=object)

# First, let's look at the effect of crayfish on invertebrate densities in the stream.  
# Initially I want you to run the analysis taking the blocking factor into account and ignoring the repeated measures aspect. 

# Create a new response variable of invertebrates with final invertebrate density (INVERTS4) minus initial invertebrate density (INVERTS1).  

# Use this as the response variable for your ANOVA.  

# However, the sample sizes are small and I want you to focus on the analysis at this point so don't worry about this aspect too much for this exercise.  

# Was it worthwhile blocking in this case?  How can you tell?


####
# Do a repeated measures ANOVA ignoring the blocking factor.  
##

#this is a big data frame, lets just grab the columns we need, to make this easier to look at and think about

# data wrangling cheatsheet - https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf

bensub <- ben[,c("TREAT","INVERTS1","INVERTS2","INVERTS3","INVERTS4")]

# what we want to end up with is this

#   TREAT   invert      value
# 1     n INVERTS1  2.0432099
# 2     s INVERTS1  1.1172840
# 3     l INVERTS1  0.1358025
# 4     n INVERTS1  2.6172840
# 5     s INVERTS1 27.5925926
# 6     l INVERTS1  0.3333333

bengather <- bensub %>% gather("invert","value",- TREAT) # so this is saying to gather everything, except for BLOCK and TREAT


model <- aov(value ~ TREAT + Error(invert/TREAT), data=bengather)
summary(model)

# Notice that multivariate and univariate results are contained in the output. 
# How do they differ?  
# Which multivariate test statistic should you use?  
# What does the output mean?  
# How do the epsilons look?  
# Should you correct and if so which one do you use?  

# Run the analysis again taking the blocking factor into account.  Was it worthwhile blocking in this case?  How can you tell?


bensub <- ben[,c("TREAT","BLOCK","INVERTS1","INVERTS2","INVERTS3","INVERTS4")]


bengather <- bensub %>% gather("invert","value",- TREAT, - BLOCK) # so this is saying to gather everything, except for BLOCK and TREAT


model <- aov(value ~ TREAT + BLOCK +  Error(invert/TREAT), data=bengather)
summary(model)
