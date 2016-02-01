# Biometry 2016 
# Lab 3
# Power Analysis

# Please answer the questions, pasting in appropriate tables and figures. 

# The first steps of a power analysis are to conduct preliminary sampling. 
# That is, you should conduct a small scale study based on the actual study you would like to do.  
# I have done this for you and provided the data. 
# Next, you take the data and determine sample size for a given power or power for a given (or range of) sample size.  
# Determining power for simple tests such as basic correlations, proportion differences, and group mean differences are easy and straightforward. These are the tests we will focus on today.  
# For more complex designs the power analyses become more difficult, but the principles are the same.
 
# load the trout dataset 
trout <- read.csv("./20160204_biometry_lab_3_power_analysis/trout.csv")

str(trout)
summary(trout)
head(trout)

# For your project, you need to evaluate the effects of radio transmitters surgically implanted in trout on their growth.  
# Ideally, transmitters will not affect growth by more than ten percent. 
# The only data available related to your study is a small study on
# brown trout conducted in New Zealand. 
# First, what is the correct test for this data?

# C=Trout without transmitters
# E=Trout with transmitters implanted
# Intial=Before implantation
# End=After 8 weeks
# Data is mass in grams.

(pttest <- power.t.test(n=10, delta= mean(trout$C_growth-trout$E_growth), sd=sd(c(trout$C_growth,trout$E_growth)), sig.level = 0.05))

# load the beetle data
beetle <- read.csv("./20160204_biometry_lab_3_power_analysis/beetle.csv")

str(beetle)
head(beetle)
summary(beetle)

# This is part of a data set from Sokal and Rohlf (1995),
# box 17.8 examining frequencies of color patterns of a 
# species of tiger beetle. 
# Use the "Equality of proportions" power analysis module to 
# determine an appropriate sample size for this study.

(pprop <- power.prop.test(n=NULL,p1=(beetle$Bright_Red/100),p2=(beetle$Not_BR/100), sig.level=0.05, power=0.9))

# load the crayfish data
crayfish <- read.csv("./20160204_biometry_lab_3_power_analysis/crayfish.csv")

str(crayfish)
summary(crayfish)
head(crayfish)

# This is part of a data set from a study that some collaborators, students and I collected as part of a study to determine effects of stream drying on crayfish habitat and refuge use. 
# I would like you to use this data to determine appropriate sample sizes to determine differences in adult Orconectes meeki density among years.  Since we have not done it yet in class 
# I will tell you that this is a one-way ANOVA with years as the grouping factor and adult O. meeki density as the response variable.  Therefore, you need to determine group means and standard deviations and then plug it into the "One-way ANOVA" power analysis.  
# How does desired power affect sample size? Alpha?
# Plug in a different effect size range and see how this affects sample size.
# How do effect size and standard deviation interact to affect sample size?

# first we only want Meekie

meeki <- crayfish[crayfish$Species=="O. meeki",] # remember we put this on the left side of the comma because we want all the rows where this is true. and we use double equals signs

# number of groups
length(unique(meeki$Year)) # this will give us the number of unique levels of meeki$Year

#how many in each group
table(meeki$Year) # this gives us a count of how many fall into each category

# between.var 
var(meeki$Total) # var is the variance function in R
 
#within group variance

var5 <- var(meeki[meeki$Year==2005,]$Total) # so we are selecting only the Year 2005, and then at the end we are tacking on the $Total argument, so we are taking just the Total column where year == 2005
var6 <- var(meeki[meeki$Year==2006,]$Total)
var7 <- var(meeki[meeki$Year==2007,]$Total)

max(var5, var6, var7)

(panova <- power.anova.test(groups=3, n=10, between.var=var(meeki$Total), within.var=max(var5, var6, var7), sig.level=0.05 ))

(panova <- power.anova.test(groups=3, n=NULL, between.var=var(meeki$Total), within.var=max(var5, var6, var7), sig.level=0.05, power=0.9))
