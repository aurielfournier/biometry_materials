library(lawstat)

levene.test(dat$VELOCITY, dat$SITE, location="median")

TukeyHSD(model, "SITE", ordered=FALSE, conf.level=0.95)
