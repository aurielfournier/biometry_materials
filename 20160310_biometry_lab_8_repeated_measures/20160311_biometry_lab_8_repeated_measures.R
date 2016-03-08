# Biometry 2016 
# Lab 8
# Repeated Measures and Randomized Block ANOVA

# packages you need
library(tidyr)
library(dplyr)
library(ggplot2)
library(ggthemes)
#Use the data in "ben.csv". 

ben <- read.csv('./20160310_biometry_lab_8_repeated_measures/ben.csv')
summary(ben)
str(ben)
head(ben)

# This file contains data from a study examining effects of crayfish on various ecosystem responses including levels of silt, detritus, chlorophyll a (measure of algal growth) and invertebrate density.  

# I have included the publication that used this data to provide background on the study and methods used. The study used a manipulative field experiment with a blocking and repeated measures design. The treatments were no crayfish (n), small crayfish (s) and large crayfish (l). We wanted to know whether crayfish treatment affected response variables and whether this changed over time. I come to you as my friendly neighborhood statistician and ask you to tell me the answer. 

# What do you say?  

############################
# randomized block 
##############################

# First, let's look at the effect of crayfish on invertebrate densities in the stream.  

# Initially I want you to run the analysis taking the blocking factor into account and ignoring the repeated measures aspect. 

# Create a new response variable of invertebrates with final invertebrate density (INVERTS4) minus initial invertebrate density (INVERTS1). 

ben$final_invert <- ben$INVERTS4 - ben$INVERTS1

## CHECK YOUR ASSUMPTIONS

# normality? 

ggplot()+geom_boxplot(data=ben, aes(x=as.factor(BLOCK), y=final_invert, fill=TREAT))+coord_flip()+theme_few()


# homogeneity of variance/covariance

bengather <-  ben[,c("TREAT","BLOCK","final_invert")] %>% # splits out the columns we want
  gather("final_invert","value",-TREAT,-BLOCK) %>% # arranges them in long form
  group_by(BLOCK,TREAT) %>% # selects the groups we are interested in
  summarize(median=median(value)) %>% # gives us the median value for each combinatino of BLOCK and TREAT 
  spread("BLOCK","median")  #arranges them so taht the treatments are the columns and the data.frame is filled with the median column values, so then the blocks are the rows

# Compound Symmetry Assumption

cov(bengather[,2:9])

# Sphericity assumption

(variance <-  ben[,c("TREAT","BLOCK","final_invert")] %>% # splits out the columns we want
  gather("final_invert","value",-TREAT,-BLOCK) %>% # arranges them in long form
  group_by(BLOCK,TREAT) %>% # selects the groups we are interested in
  summarize(variance=var(value)) %>% # gives us the median value for each combinatino of BLOCK and TREAT 
  spread("TREAT","variance")) 


# Use this as the response variable for your ANOVA.  


model <- aov(final_invert ~ TREAT + BLOCK, data=ben) 

summary(model) 

# Was it worthwhile blocking in this case?  How can you tell?




############################
## Repeated Measures
############################


############
# Do a repeated measures ANOVA ignoring the blocking factor.  
############

# Compound Symmetry Assumption

bensub <- ben[,c("TREAT","BLOCK","INVERTS1","INVERTS2","INVERTS3","INVERTS4")] 

cov(bensub[,3:6])

# Sphericity 

(variance <-  ben[,c("TREAT","BLOCK","INVERTS1","INVERTS2","INVERTS3","INVERTS4")] %>% # splits out the columns we want
  gather("final_invert","value",-TREAT,-BLOCK) %>% # arranges them in long form
  group_by(BLOCK,TREAT) %>% # selects the groups we are interested in
  summarize(variance=var(value)) %>% # gives us the median value for each combinatino of BLOCK and TREAT 
  spread("TREAT","variance")) 


bengather <- ben[,c("TREAT","INVERTS1","INVERTS2","INVERTS3","INVERTS4")] %>% gather("invert","value",- TREAT)  # so this is saying to gather everything, except for BLOCK and TREAT


model <- aov(value ~ TREAT + Error(invert/TREAT) , data=bengather)
summary(model) 



# Tukey's test for (non)-Additivity 

library(dae) 


tukey.1df(model, bengather, error.term="Within")
