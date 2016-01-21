# Biometry 2016 
# Lab 2 
# Graphing

# Packages You Need

library(ggplot2)
library(dplyr)
library(gridExtra)

radish <- read.csv("./20160128_biometry_lab_2_graphing/RAD_GROW.csv")

# Check to make sure the different columns were read in correctly
str(radish)
head(radish)

summary(radish)

radish_sum <- radish %>% group_by(TREAT) %>% summarise_each(funs(min, max, mean, median))
  
write.csv(radish_sum, "./20160128_biometry_lab_2_graphing/outputs/radish_sum.csv")

#
#
#

chloro <- read.csv("./20160128_biometry_lab_2_graphing/Chlorophyll_e95_for_graph_lab.csv")

# Check to make sure the different columns were read in correctly
str(chloro)
head(chloro)


chloro_sum <- chloro[,c("Pool","DRYING","BASS","Chl_a_mg_m2")] %>% group_by(Pool,DRYING,BASS)  %>% summarise_each(funs(min, max, mean, median))

write.csv(chloro_sum, "./20160128_biometry_lab_2_graphing/outputs/chloro_sum.csv")

#
#
#

# STEM AND LEAF PLOTS

# this is one rare instance where we will not use ggplot

stem(radish[radish$TREAT=="DARK",]$RAD_GROW)

stem(radish[radish$TREAT=="LIGHT",]$RAD_GROW)

#
#
#

# Histograms

ggplot()+geom_histogram(data=radish, aes(x=RAD_GROW))+facet_wrap(~TREAT)+theme_bw()

ggplot()+geom_histogram(data=radish, aes(x=RAD_GROW, group=TREAT, fill=TREAT), position="dodge")+theme_bw()

#
#
#

ten <- data.frame(a=rnorm(10, 0,1))
hundred <- data.frame(a=rnorm(100,0,1))
thousand <- data.frame(a=rnorm(1000,0,1))
exp <- data.frame(a=rexp(1000,1))
unif <- data.frame(a=runif(1000,0,1))

(a <- ggplot()+geom_histogram(data=ten, aes(x=a))+theme_bw()+xlim(-4,6))
(b <- ggplot()+geom_histogram(data=hundred, aes(x=a))+theme_bw()+xlim(-4,6))
(c <- ggplot()+geom_histogram(data=thousand, aes(x=a))+theme_bw()+xlim(-4,6))
(d <- ggplot()+geom_histogram(data=exp, aes(x=a))+theme_bw()+xlim(-4,6))
(e <- ggplot()+geom_histogram(data=unif, aes(x=a))+theme_bw()+xlim(-4,6))
grid.arrange(a,b,c,d,e, ncol=1)

#
#
#

# Boxplots

ggplot()+geom_boxplot(data=radish, aes(x=TREAT, y=RAD_GROW))+theme_bw()

ggplot()+geom_boxplot(data=thousand, aes(y=a, x=1))+theme_bw()
ggplot()+geom_boxplot(data=exp, aes(y=a, x=1))+theme_bw()
ggplot()+geom_boxplot(data=unif, aes(y=a, x=1))+theme_bw()

#
#
#

# probability plot

ggplot()+stat_qq(data=thousand, aes(sample=a))+theme_bw()
ggplot()+stat_qq(data=exp, aes(sample=a))+theme_bw()
ggplot()+stat_qq(data=unif, aes(sample=a))+theme_bw()
ggplot()+stat_qq(data=radish, aes(sample=RAD_GROW, group=TREAT, color=TREAT))+theme_bw()
