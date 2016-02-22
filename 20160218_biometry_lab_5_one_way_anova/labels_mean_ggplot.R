# adding text labels

lab <- data.frame(SITE=c("UPPER","MIDDLE","LOWER"),label=c("a","b","b"))


ggplot()+geom_boxplot(data=dat, aes(x=SITE, y=DEP_LOG))+theme_few()+coord_flip()+geom_text(data=lab, aes(x=SITE,y=1, label=label))


# giving it mean 

sumu <- summary(dat[dat$SITE=="UPPER",]$DEP_LOG)
summ <- summary(dat[dat$SITE=="MIDDLE",]$DEP_LOG)
suml <- summary(dat[dat$SITE=="LOWER",]$DEP_LOG)

sumsum <- data.frame(rbind(sumu, summ, suml))

sumsum$SITE <- c("UPPER","MIDDLE","LOWER")

colnames(sumsum) <- c("ymin","lower","median","mean","upper","ymax","SITE")

ggplot()+
  geom_boxplot(data=sumsum,aes(x=SITE,lower=lower, upper=upper, middle=mean, ymax=ymax, ymin=ymin), stat="identity")
  