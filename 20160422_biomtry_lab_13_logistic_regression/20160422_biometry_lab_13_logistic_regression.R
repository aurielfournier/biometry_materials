# Biometry 2016 
# Lab 13
# Logistic Regression


#logistic regression in R
# glm(response ~ predictor, family=binomial(link='logit'), data=object)

# A colleague provides you with data ("H_sulphuria.csv") containing presence/absence records of a predaceous diving beetle (Dytiscidae: Heterosternuta sulphuria) that is of conservation concern in Arkansas.  
# The data also includes environmental data that was collected from a GIS database at various spatial scales: watershed, riparian, and local.

# You have been asked to compare a few specific hypotheses, listed below.  
# Please check that the assumptions are met for each logistic regression model.  
# Be sure to check for collinearity among predictor variables if multiple predictors are used.  
# Be sure to save the residuals
# Use AIC or BIC when making comparisons among models.

# Report any models and/or predictor variables that significantly affect occurrence of H. sulphuria.  
# This species is known to be a headwater specialist that is sensitive to watershed area ('SHED_AREA'), so this should be included as a predictor in all models.  

# H1)  Percent urbanization in watersheds ('SHED_URBAN') significantly affects the probability of H. sulphuria occupying stream sites.
# H2)  Percent urbanization in watersheds ('SHED_URBAN') and percent forest in riparian zones ('RIPARIAN_FOREST') together provide better estimates-compared to H1-of the probability of H. sulphuria occupying sites.
# H3)  Percent forest in riparian zones ('RIPARIAN_FOREST') significantly interacts with urbanization in watersheds ('SHED_URBAN').  In other words, the negative effect of urbanization in the watershed is dependent on how much of the riparian zone is forested.

# After evaluating and comparing each of these hypotheses, please use a stepwise procedure to identify other predictor variables that may be important.  
# Again, be sure to check for collinearity among predictor variables.  
# What are the potential problems with stepwise selection procedures?

