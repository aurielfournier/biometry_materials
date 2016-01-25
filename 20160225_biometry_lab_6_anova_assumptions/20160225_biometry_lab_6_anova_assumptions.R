# Biometry 2016 
# Lab 6
# Anova Assumptions and Transformations


dat <- read.csv("./20160225_biometry_lab_6_anova_assumptions/medley.csv")

model <- aov(data=dat, DIVERSTY ~ ZINC)
modeltable <- summary(model)
plot(model) # this function can be seen as a bit odd since you have to kpt return a few times to see all the plots

# how to pull out the residuals
resid <- model$residuals

###
# Excercise
###

# Are observations normally distributed, independent, with homogeneity of variance? 
# Include graphs with your answers.  
# Do you need to transform the data? 

# square root transformation sqrt()
# natural log log()
# base-10 log log10()
# exponential exp()
# sin sin()
# raise to the third power variable^3

# After you run the ANOVA, check the residuals.  
# (Hint, save the residuals as a data file).  
# Do they look skewed?  


###
# time to simulate a BUNCH OF DATA
###

uniforms <- data.frame(a=rep(0,30))

for(i in 1:30){
  uniforms[i,"a"] <- rnorm(1,1,3)
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
