newdat <- dat[,c("logtotal","SEASON","STREAMTYPE")] %>% group_by(SEASON,STREAMTYPE) %>% summarise_each(funs(mean, sd, se=sd(.)/sqrt(n())))

# this tells R what order you want them in
newdat$SEASON <- factor(newdat$SEASON, levels=c("April","June","August","October"))

# this makes STREAMTYPE a factor, so they are treated as two levels instead of numbers
newdat$STREAMTYPE <- as.factor(newdat$STREAMTYPE)

ggplot(data=newdat,aes(x=SEASON, y=mean, group=STREAMTYPE, color=STREAMTYPE))+geom_line()+geom_point()+  geom_errorbar(aes(ymin=mean-se, ymax=mean+se, color=STREAMTYPE, group=STREAMTYPE), width=.1)+theme_bw()