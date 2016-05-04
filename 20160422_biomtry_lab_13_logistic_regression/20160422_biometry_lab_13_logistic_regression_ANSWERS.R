# Biometry 2016 
# Lab 13
# Logistic Regression

library(ggplot2) # graphing
library(ggthemes) # theme_few
library(ggfortify) # autoplot
library(nlme) ## NEW PACKAGE # gives us BIC()
library(usdm) ## NEW PACKAGE # vif()
library(MASS)





#logistic regression in R
# glm(response ~ predictor, family=binomial(link='logit'), data=object)

# A colleague provides you with data ("H_sulphuria.csv") containing presence/absence records of a predaceous diving beetle (Dytiscidae: Heterosternuta sulphuria) that is of conservation concern in Arkansas.  

dat <- read.csv("H_sulphuria.csv")
head(dat)
str(dat)
summary(dat)

dat <- dat[!is.na(dat$RIPARIAN_FOREST),] # remove the NA values from Riparian Forest


### how to standerdize/scale variables in R

#?scale

summary(dat[,c("SHED_AREA","RIPARIAN_FOREST")])
dat$scale_shed_area <- scale(dat$SHED_AREA)
dat$scale_riparian_forest <- scale(dat$RIPARIAN_FOREST)
summary(dat[,c("scale_shed_area","scale_riparian_forest")])

# The data also includes environmental data that was collected from a GIS database at various spatial scales: watershed, riparian, and local.

# You have been asked to compare a few specific hypotheses, listed below.  

### ASSUMPTIONS  



# binomial plot

ggplot(data=dat, aes(x=SHED_AREA, y=H_SULPHURIA))+geom_point()+geom_smooth(method="glm",method.args=list(family="binomial"))+theme_few()

ggplot(data=dat, aes(x=SHED_URBAN, y=H_SULPHURIA))+geom_point()+geom_smooth(method="glm",method.args=list(family="binomial"))+theme_few()

ggplot(data=dat, aes(x=RIPARIAN_FOREST, y=H_SULPHURIA))+geom_point()+geom_smooth(method="glm",method.args=list(family="binomial"))+theme_few()

# absence of strong collinearity among predictor variables if multiple predictors are used.  

vif(dat[,c("SHED_AREA","SHED_URBAN","RIPARIAN_FOREST")])
#VIF > 10 is a sign of strong collinearity 

##############################
# Report any models and/or predictor variables that significantly affect occurrence of H. sulphuria ('H_SULPHURIA').

# This species is known to be a headwater specialist that is sensitive to watershed area ('SHED_AREA'), so this should be included as a predictor in all models.  

###################################
# H1)  Percent urbanization in watersheds ('SHED_URBAN') significantly affects the probability of H. sulphuria occupying stream sites.

h1 <- glm(H_SULPHURIA ~ SHED_AREA + SHED_URBAN, data=dat, family=binomial(link="logit"))

h1resid <- h1$residuals

summary(h1)

autoplot(h1, which=1:6, ncol=3, label.size=3)+theme_few()

AIC(h1)
BIC(h1)

# H2)  Percent urbanization in watersheds ('SHED_URBAN') and percent forest in riparian zones ('RIPARIAN_FOREST') together provide better estimates-compared to H1-of the probability of H. sulphuria occupying sites.

h2 <- glm(H_SULPHURIA ~ SHED_AREA + SHED_URBAN + RIPARIAN_FOREST, data=dat, family=binomial(link="logit"))

h2resid <- h2$residuals

summary(h2)

autoplot(h2, which=1:6, ncol=3, label.size=3)+theme_few()

AIC(h2)
BIC(h2)

# H3)  Percent forest in riparian zones ('RIPARIAN_FOREST') significantly interacts with urbanization in watersheds ('SHED_URBAN').  In other words, the negative effect of urbanization in the watershed is dependent on how much of the riparian zone is forested.

h3 <- glm(H_SULPHURIA ~ SHED_AREA + SHED_URBAN * RIPARIAN_FOREST, data=dat, family=binomial(link="logit"))

h3resid <- h3$residuals

summary(h3)

autoplot(h3, which=1:6, ncol=3, label.size=3)+theme_few()

AIC(h3)
BIC(h3)


# create an AIC or BIC table
AIC(h1,h2, h3)
BIC(h1, h2, h3)


## Goodness of Fit (we're using h3 since that is our model that has all of our covariates, aka our global model)

1 - pchisq(deviance(h3), df.residual(h3))
# a large value indicates no evidence of lack of fit (aka good = big)


# After evaluating and comparing each of these hypotheses, please use a stepwise procedure to identify other predictor variables that may be important.  

model <-glm(H_SULPHURIA ~ SHED_AREA + SHED_URBAN + RIPARIAN_FOREST, data=dat, family=binomial(link="logit")) # add some other variables?

both <- stepAIC(model, direction="both")

summary(both) ## aka this is h1


back <- stepAIC(model, direction="backward")

summary(back) ## aka this is h1


forward <- stepAIC(model, direction="forward")

summary(forward) ## aka this is h2


# What are the potential problems with stepwise selection procedures?

