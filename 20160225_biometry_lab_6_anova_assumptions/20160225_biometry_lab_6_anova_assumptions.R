# Biometry 2016 
# Lab 6
# Anova Assumptions and Transformations
library(ggplot2)
library(ggthemes)
install.packages('ggfortify')
library(ggfortify) # new package!!

dat <- read.csv("./20160225_biometry_lab_6_anova_assumptions/medley.csv")

model <- aov(data=dat, DIVERSITY ~ ZINC)
modeltable <- summary(model)

# After you run the ANOVA, check the residuals.  
resid <- model$residuals # this is how you pull out the residuals, if you want to

autoplot(model, which = 1:6, ncol = 3, label.size = 3)+theme_few() # this comes from the ggfortify function which makes doing post model graphs for examination very simple. 


# Do they look skewed?  



TukeyHSD(model, "ZINC", ordered=FALSE, conf.level=0.95)

kruskal.test(dat$DIVERSITY, dat$ZINC)

library(lawstat) # need these for levene.test

levene.test(dat$DIVERSITY, dat$ZINC, location="median")



###
# Excercise
###

# Are observations normally distributed, independent, with homogeneity of variance? 
## look back at last weeks scripts to refresh your memory

# Do you need to transform the data? 

## ways to do different transformations in R

# square root transformation sqrt()
# natural log log()
# base-10 log log10()
# exponential exp()
# sin sin()
# rails ot the second power variable^2
# raise to the third power variable^3





###
# time to simulate a BUNCH OF DATA
###

uniforms <- data.frame(a=rep(0,30)) # rep() repeats the first argument as many time as the second argument rep(0,30) repeats 0 30x

for(i in 1:30){
  uniforms[i,"a"] <- rnorm(1,1,3) # rnorm generates a random number from a normal distribution for more info check out ?rnorm
}

ubar1 <- mean(uniforms[1:10,])
ubar2 <- mean(uniforms[11:20,])
ubar3 <- mean(uniforms[21:30,])

ubar <- mean(uniforms[,"a"])

ss1 <- ((10)*(ubar1-ubar)^2)
ss2 <- ((10)*(ubar2-ubar)^2)
ss3 <- ((10)*(ubar3-ubar)^2)

ssbetween <- sum(ss1, ss2, ss3)
msbetween <- ssbetween/2

uniforms$y <- NA

for(i in 1:30){
  uniforms[i,"y"] <- (uniforms[i,"a"]-ubar)^2
}

sstotal <- sum(uniforms[,"y"])
ssresidual <- sstotal - ssbetween
msresidual <- ssresidual/27
f <- msbetween/msresidual
fcrit <- qf(0.95, 1, 27)
signif <- f>fcrit
