# Biometry 2016 
# Lab 8
# Repeated Measures and Randomized Block ANOVA


# packages you need
library(tidyr)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(car)
library(dae) 
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

bencov <-  ben[,c("TREAT","BLOCK","final_invert")] %>% # splits out the columns we want
  gather("final_invert","value",-TREAT,-BLOCK) %>% # arranges them in long form
  group_by(BLOCK,TREAT) %>% # selects the groups we are interested in
  summarize(median=median(value)) %>% # gives us the median value for each combinatino of BLOCK and TREAT 
  spread("TREAT","median")  #arranges them so taht the treatments are the columns and the data.frame is filled with the median column values, so then the blocks are the rows

# Compound Symmetry Assumption

cov(bencov[,2:4]) 

# so this is a symetrical matrix which means the values on either side of the upper left to lower right diagnol are the same. So we only need to look at one half (see below) 

#> cov(bengather[,2:4])
#       l           n          s
#l  0.17745432  
#n  0.08747838  3.33792900 
#s -0.20332280 -0.13859655  0.5026366

# Sphericity assumption

variance <-  ben[,c("TREAT","BLOCK","final_invert")] %>% # splits out the columns we want
  gather("final_invert","value",-TREAT,-BLOCK) %>% # arranges them in long form
  group_by(BLOCK,TREAT) %>% # selects the groups we are interested in
  summarize(variance=var(value)) %>% # gives us the median value for each combinatino of BLOCK and TREAT 
  spread("TREAT","variance")

variance$ln <- variance$l - variance$n
variance$ls <- variance$l - variance$s
variance$ns <- variance$n - variance$s

apply(variance[,5:7], 2, var)
# so this gives us the variances between the treatments (ln is the variance of the l vs the n treatment)

##########################
## Check for interaction between treatment and block
##########################

ben[,c("TREAT","BLOCK","final_invert")] %>% 
gather("final_invert","value",-TREAT,-BLOCK) %>% 
  ggplot(aes(x = BLOCK, y = value, colour = TREAT, group=TREAT)) +
  stat_summary(fun.y=mean, geom="point")+
  stat_summary(fun.y=mean, geom="line")+theme_few()


## Run the actual model
## we just add the treatment and Blocking covaraites together

model <- aov(final_invert ~ TREAT + as.factor(BLOCK), data=ben) 

summary(model)  


# Was it worthwhile blocking in this case?  How can you tell?

############################
## Repeated Measures
############################


# Do a repeated measures ANOVA ignoring the blocking factor.  
# normality? 

bengather <- ben[,c("TREAT","INVERTS1","INVERTS2","INVERTS3","INVERTS4")] %>% gather("BLOCK","value",- TREAT)   # so this is saying to gather everything, except for BLOCK and TREAT

ggplot()+geom_boxplot(data=bengather, aes(x=as.factor(BLOCK), y=value, fill=TREAT))+coord_flip()+theme_few() 


# Compound Symmetry Assumption

bensub <-  ben[,c("TREAT","INVERTS1","INVERTS2","INVERTS3","INVERTS4")] %>% # splits out the columns we want
  gather("BLOCK","value",-TREAT) %>% # arranges them in long form
  group_by(BLOCK,TREAT) %>% # selects the groups we are interested in
  summarize(median=median(value)) %>% # gives us the median value for each combinatino of BLOCK and TREAT 
  spread("TREAT","median") 

cov(bensub[,2:4]) # are these numbers similar?

# Sphericity 

(variance <-  ben[,c("TREAT","INVERTS1","INVERTS2","INVERTS3","INVERTS4")] %>% # splits out the columns we want
  gather("BLOCK","value",-TREAT) %>% # arranges them in long form
  group_by(TREAT, BLOCK) %>% # selects the groups we are interested in
  summarize(variance=var(value)) %>% # gives us the median value for each combinatino of BLOCK and TREAT 
  spread("TREAT","variance"))  

variance$ln <- variance$l - variance$n
variance$ls <- variance$l - variance$s
variance$ns <- variance$n - variance$s

apply(variance[,5:7], 2, var)  # are these numbers similar? 


##########################
## Check for interaction between treatment and block
##########################

ben[,c("TREAT","INVERTS1","INVERTS2","INVERTS3","INVERTS4")] %>% # splits out the columns we want
  gather("BLOCK","value",-TREAT)%>% 
  ggplot(aes(x = BLOCK, y = value, colour = TREAT, group=TREAT)) +
  stat_summary(fun.y=mean, geom="point")+
  stat_summary(fun.y=mean, geom="line")+theme_few() 

###
## Run the Repeated Measures Model without the BLOCK
###

bengather <- ben[,c("TREAT","INVERTS1","INVERTS2","INVERTS3","INVERTS4","BLOCK")] 

model <- lm(cbind(INVERTS1, INVERTS2, INVERTS3, INVERTS4) ~ TREAT, data=bengather) # this takes the repeated measure into account, with each of the columns of the response containing one of the repeated measures

mauchly.test(model) # runs the mauchly test

idata <- expand.grid(invert=factor(c(1,2,3,4))) # gives us grid of the repeated measures levels

av.ok <- Anova(model, idata=idata, idesign=~invert ) 

summary(av.ok) # this contains A LOT 

###
## Run the Repeated Measures Model with the BLOCK
### 

bengather <- ben[,c("TREAT","INVERTS1","INVERTS2","INVERTS3","INVERTS4","BLOCK")] 

model <- lm(cbind(INVERTS1, INVERTS2, INVERTS3, INVERTS4) ~ TREAT + BLOCK, data=bengather) # this takes the repeated measure into account, with each of the columns of the response containing one of the repeated measures

mauchly.test(model) # runs the mauchly test

idata <- expand.grid(invert=factor(c(1,2,3,4))) # gives us grid of the repeated measures levels # gives us grid of the repeated measures levels

av.ok <- Anova(model, idata=idata, idesign=~invert ) 

summary(av.ok) # this contains A LOT 


##################
# Tukey's test for (non)-Additivity 
##################
tukey.1df(model, bengather, error.term="Within")
