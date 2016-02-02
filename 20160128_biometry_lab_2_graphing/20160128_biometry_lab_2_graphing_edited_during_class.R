# Biometry 2016 
# Lab 2 
# Graphing

# Packages You Need
library(ggplot2) # graphing package
library(dplyr) # this package is very powerful for summarizing and manipulating data
library(gridExtra) # works with ggplot to create grids of graphs
library(ggthemes) # gives you additional ggplot themes
library(RColorBrewer) # this gives you custom color ramps, including color blind friendly stuff

radish <- read.csv("./20160128_biometry_lab_2_graphing/RAD_GROW.csv")

# Check to make sure the different columns were read in correctly
str(radish)
head(radish)
summary(radish)

# today we're learning graphing and dplyr

# one of the first things we're going to learn is a thing called 'pipes (%>%) 
# which allows us to stitch together functions into one string so we don't have to create many intermediate objects

# so what we are doing here is we're saying which object we want, and then we are piping that object into group_by
# group_by allows us to define one (or more) columns by which we want to group our data, in this case we want to group it by treatment
# then we pipe the output from group_by into summarise_each, which allows us to define which functions we want summarized for each group 
# in this case we are asking for min, max, mean and median, but you can define a large number of functions or write your own
# then sinec we have assigned this string of pipes to radish_sum (via the radish_sum <-) we now have the output saved in radish_sum
# this allows us to call this summary back whenever we want it
# and it allows us to write it out of R. 


# dplyr cheatsheet for data manipulation https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf 

radish_sum <- radish %>% group_by(TREAT) %>% summarise_each(funs(min, max, mean, median))
radish_sum


# instead of doing this

radish_group <- group_by(radish, TREAT)
radish_sum <- summarise_each(radish_group, funs(min,max,mean,median))
radish_sum
  
write.csv(radish_sum, "./20160128_biometry_lab_2_graphing/outputs/radish_sum.csv", row.names=FALSE)

#
#
#

chloro <- read.csv("./20160128_biometry_lab_2_graphing/Chlorophyll_e95_for_graph_lab.csv")

# Check to make sure the different columns were read in correctly
str(chloro)
head(chloro)

# ok here we are doing the same thing we did for the radishes, BUT we are only inputing some of the columns. 

# chloro[,c("Pool","DRYING","BASS","Chl_a_mg_m2")] means that we only want those four columns, instead of all the columns in chloro. 
# We are doing this because we do not want to have Area_m_2 or End summarized. 
# so we take this subset of chloro and we intput it into group_by again, but this time we give it THREE columns to group by, and then pipe that into summarise_each again

chloro_sum <- chloro[ ,c("Pool","DRYING","BASS","Chl_a_mg_m2")] %>% group_by(Pool,DRYING,BASS)  %>% summarise_each(funs(min, max, mean, median))

chloro_sum

write.csv(chloro_sum, "./20160128_biometry_lab_2_graphing/outputs/chloro_sum.csv", row.names =FALSE)

#
#
#

# STEM AND LEAF PLOTS

# this is one rare instance where we will not use ggplot because these aren't plots the same way that a boxplot is

dark <- radish[radish$TREAT=="DARK", ]

stem(dark$RAD_GROW)

light <- radish[radish$TREAT=="LIGHT", ]

stem(light$RAD_GROW)

stem(radish[radish$TREAT=="DARK",]$RAD_GROW)

stem(radish[radish$TREAT=="LIGHT",]$RAD_GROW)

#
#
#

# ggplot is different then many kinds of coding in R because we add together multiple functions to build the differnet parts of the graph
# we ALWAYS start with ggplot() and you can define things within ggplot() but often you end up doing it later on.
# IF you are going to use the same object as your data in multiple layers of the graph, define it in ggplot(data=object)
# otherwise you can define it in the geom_ layer. 
# the geom_ layers are the ones that create your boxplot, or histogram, or whatever
# within your geom_ you will need to have an aes() function inside
# aes = aesthetics
# this is where you define x, and y (if necessary) along with what covariates you want to use for grouping, coloring or filling

# this is often a good place to start
?geom_histogram
# go down to aesthetics and the items which are bolded are the ones that you NEED to have for this kind of geom
# ggplot is crazy customizable, so you can always change things around

# Histograms

ggplot()+
  geom_histogram(data=radish, aes(x=RAD_GROW))+
  facet_wrap(~TREAT)+ # facet wrap means that it creates a seperate graph for each level of that covariate, in this case  treatment
  theme_bw() # I don't like the default way that ggplots look, luckily there are lots of themes you can use (package ggthemes ha smore) or you can build your own. I have one called theme_krementz that I often use when making graphs for my adviser
# theme_bw will make a very plain graph. 

ggplot()+
  geom_histogram(data=radish, aes(x=RAD_GROW, group=TREAT, fill=TREAT), position="dodge")+ # we use 'position="dodge"' because we don't want the bars to over lab. you you can try it with and without to see the difference. 
  theme_bw()

#
#
#

# here we are generating some random data, under a normal distribution (rnorm), exponential (rexp) and uniform distribution (runif). 
# if you aren't sure which arguments are which use ?rnorm,  ?rexp or ?runif 

# so this is taking the output of rnorm and assigning it to column "a" within the data frame we are creating. This is a common way of creating data in R. 

ten <- data.frame(a=rnorm(10, 0,1))
hundred <- data.frame(a=rnorm(100,0,1))
thousand <- data.frame(a=rnorm(1000,0,1))
exp <- data.frame(a=rexp(1000,1))
unif <- data.frame(a=runif(1000,0,1))

# by wrapping the entire graph in parentheses when we run the line of code it will BOTH save the graph to the object and generate the graph for us. This is great for checking graphs as we go, but still having them saved for use in grid.arrange

(a <- ggplot()+
  geom_histogram(data=ten, aes(x=a))+
  theme_bw()+
  xlim(-4,6))
(b <- ggplot()+
  geom_histogram(data=hundred, aes(x=a))+
  theme_bw()+
  xlim(-4,6))
(c <- ggplot()+
  geom_histogram(data=thousand, aes(x=a))+
  theme_bw()+
  xlim(-4,6))
(d <- ggplot()+
  geom_histogram(data=exp, aes(x=a))+
  theme_bw()+
  xlim(-4,6))
(e <- ggplot()+ geom_histogram(data=unif, aes(x=a))+theme_bw()+ xlim(-4,6))
# this allows us to arrange multiple graphs in the same image. We input each object as an argument and then define either the number of columns or rows. 
grid.arrange(a,b,c,d,e, ncol=1)
grid.arrange(a,b,c,d,e,a, nrow=2)

# if you are saving a single ggplot graph you can use ggsave() to save it outside of R
# you can define the height and width and dpi which is very useful for publications
ggsave(a, file="./20160128_biometry_lab_2_graphing/graph_a.png", width=5, height=5, units="cm", dpi=300)

# if you are trying to save a panel of graphs such as in grid.arrange you will need to use this method
# in png the dpi is res (for resolutino)
png(file="./20160128_biometry_lab_2_graphing/grid_arrange_graph.png", units="cm", width=10, height=18, res=300)
grid.arrange(a,b,c,d,e,ncol=1)
dev.off()

#
#
#

# Boxplots

# so here is an example of a plot where we need x AND y

ggplot()+
  geom_boxplot(data=radish, aes(x=TREAT, y=RAD_GROW))+
  theme_bw()

# here we are giving x = 1 because we don't really care about x, we just want the things on y plotted
ggplot()+
  geom_boxplot(data=thousand, aes(y=a, x=1))+
  theme_bw()+coord_flip()
ggplot()+
  geom_boxplot(data=exp, aes(y=a, x=1))+
  theme_bw()
ggplot()+
  geom_boxplot(data=unif, aes(y=a, x=1))+
  theme_bw()

#
#
#

# probability plot

# ok so here we check out ?stat_qq and we see that we need to define a sample instead of an x or y
# this is why its good to check
ggplot()+
  stat_qq(data=thousand, aes(sample=a))+
  theme_bw()

ggplot()+
  stat_qq(data=exp, aes(sample=a))+
  theme_bw()
ggplot()+
  stat_qq(data=unif, aes(sample=a))+
  theme_bw()


ggplot()+
  stat_qq(data=radish, aes(sample=RAD_GROW, group=TREAT, color=TREAT))+ # so here we are using group and color arguments this tells ggplot that we want it to split out the points by treatment and to give each level of treatment a unique color. 
  theme_bw()


###################################
## THEMES ##
###################################

ggplot()+
  geom_boxplot(data=radish, aes(x=TREAT, y=RAD_GROW))

ggplot()+
  geom_boxplot(data=radish, aes(x=TREAT, y=RAD_GROW))+ 
  ggtitle("TITLE HERE")+ 
  xlab("text here")+ 
  ylab("text here")

ggplot()+
  geom_boxplot(data=radish, aes(x=TREAT, y=RAD_GROW))+
  ggtitle("TITLE HERE")+ 
  xlab("text here")+ 
  ylab("text here") + 
  theme_bw()

ggplot()+
  geom_boxplot(data=radish, aes(x=TREAT, y=RAD_GROW))+ 
  ggtitle("TITLE HERE")+ 
  xlab("text here")+ 
  ylab("text here") + 
  theme_calc()

ggplot()+
  geom_boxplot(data=radish, aes(x=TREAT, y=RAD_GROW))+ 
  ggtitle("TITLE HERE")+ 
  xlab("text here")+ 
  ylab("text here") + 
  theme_economist()

ggplot()+
  geom_boxplot(data=radish, aes(x=TREAT, y=RAD_GROW))+ 
  ggtitle("TITLE HERE")+ 
  xlab("text here")+ 
  ylab("text here") + 
  theme_economist_white()

ggplot()+
  geom_boxplot(data=radish, aes(x=TREAT, y=RAD_GROW))+ 
  ggtitle("TITLE HERE")+ 
  xlab("text here")+ 
  ylab("text here") + 
  theme_few()

ggplot()+
  geom_boxplot(data=radish, aes(x=TREAT, y=RAD_GROW))+ 
  ggtitle("TITLE HERE")+ 
  xlab("text here")+ 
  ylab("text here") + 
  theme_gdocs()

ggplot()+
  geom_boxplot(data=radish, aes(x=TREAT, y=RAD_GROW))+ 
  ggtitle("TITLE HERE")+ 
  xlab("text here")+ 
  ylab("text here") + 
  theme_wsj()+
  scale_x_discrete(labels=c("dark","light"))

###############################
# BUT YOU CAN DO IT YOURSELF
# OF COURSE
###############################

# these is where ggplot can become really really exhausting
# ALMOST anything you want to do, can be done

# things I know cannot be done
###############################################
# you cannot have two different y axis

## so you can add things onto a default theme, to make it better/what you want
## here we can remove the gridlines from theme_bw

ggplot()+
  geom_boxplot(data=radish, aes(x=TREAT, y=RAD_GROW))+ 
  ggtitle("TITLE HERE")+ 
  xlab("text here")+ 
  ylab("text here")+
  theme_bw()+
  theme(panel.grid=element_blank())


## Custom theme functions


theme_krementz <- function(){
  theme(axis.text.x = element_text(size=12,color="black", ang=90), # sets the size, color and angle of the x axis text
        axis.text.y = element_text(size=12,color="black"), # sets the size and color of the y axis text
        axis.title.y=element_text(size=20), # sets the size of the y axis title
        plot.background = element_blank(), # makes teh plot background blank (this is the entire thing)
        panel.border=element_blank(), # makes the panel border blank (this is the smaller box)
        panel.grid.major= element_line(colour=NA),# remove major grid lines
        panel.grid.minor=element_line(colour=NA), # remove the minor grid lines
        title=element_text(size=20), # sets title size
        panel.background = element_rect(fill = "white"), # sets background of th smaller box 
        axis.line=element_line(colour="black"), # sets the color of the x and y axis lines, instead of having a box around the panel
        strip.background=element_rect(fill="white", color="black"),  # when we use facet_wrap this is important
        strip.text=element_text(size=15)) # when we use facet_wrap this is important 
}


ggplot()+
  geom_boxplot(data=radish, aes(x=TREAT, y=RAD_GROW))+ 
  ggtitle("TITLE HERE")+ 
  xlab("text here")+ 
  ylab("text here")+
  theme_krementz()

radish$time <- c(rep(seq(1:(nrow(radish)/2)))) #lets pretend that there is a time variable here so we can make a line graph

# graph with interior legend
ggplot()+
  geom_line(data=radish, aes(x=time, y=RAD_GROW, group=TREAT, color=TREAT))+
  ggtitle("Radish growth over time")+
  ylab("Radish growth (cm)")+
  xlab("time")+
  theme_krementz()+ # so this uses the custom theme we already built
  theme(legend.background = element_rect(fill = "white"),
        legend.key=element_rect(fill="white"),# this makes the background of the legend white
        legend.position = c(.15,.85), # this tells ggplot where to put the legend in exact coordinates
        legend.direction = "vertical" # this tells ggplot what direction to make the list
  )+
  scale_color_discrete(name="Treatments") 


ggplot()+
  geom_line(data=radish, aes(x=time, y=RAD_GROW, group=TREAT, color=TREAT))+
  ggtitle("Radish growth over time")+
  ylab("Radish growth (cm)")+
  xlab("time")+
  theme_krementz()+ # so this uses the custom theme we already built
  theme(legend.background = element_rect(fill = "white"), # this makes the background of the legend white
        legend.position = "NA", # this tells ggplot where to put the legend 
        legend.direction = "horizontal" # this tells ggplot what direction to make the list
  )+
  scale_color_discrete(name="Treatments") # this titles the legend the "\n" is a line break


######################
# Colors (RColorBrewer)
#####################
#http://colorbrewer2.org/

display.brewer.all(n=NULL, type="all", select=NULL, exact.n=TRUE,colorblindFriendly=TRUE)

# explain WHAT this is doing
mypalette<-brewer.pal(3,"Paired")

ggplot()+
  geom_line(data=radish, aes(x=time, y=RAD_GROW, group=TREAT, color=TREAT))+
  ggtitle("Radish growth over time")+
  ylab("Radish growth (cm)")+
  xlab("time")+
  theme_krementz()+ # so this uses the custom theme we already built
  theme(legend.background = element_rect(fill = "white"),
        legend.key=element_rect(fill="white"),# this makes the background of the legend white
        legend.position = "top", # this tells ggplot where to put the legend 
        legend.direction = "horizontal")+ # this tells ggplot what direction to make the list
  scale_color_manual(name="Treatments",values=c("LIGHT"="#A6CEE3","DARK"=mypallete[2])



##########################################################################################
# for more details on ggplot graphing and how to customize things
# https://github.com/aurielfournier/AOU_workshop/blob/master/AOUworkshop_4_GGPLOT.R
# https://github.com/jennybc/ggplot2-tutorial
#############################################################################################

# Questions
# Using the file presnork.csv answer the following questions.
# Are the sizes of trout normally distributed?  Are there differences between the size distributions of brook trout (sp 1) and rainbow trout (sp 2)?  What are the mean sizes for brook trout and rainbow trout?  Could you make an estimate of ages from this data and what type of plot would you use to do so?  




# Using the file tottrhab.csv answer the following questions.
# How are the focal velocities (focvel) of brook trout and rainbow trout distributed?  Does a box plot show differences between these species?  Are there "outside values"?  How should you deal with "outside values"?  What is the third quartile for rainbow trout?
