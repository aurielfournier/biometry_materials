
# seperate plots
ggplot()+geom_point(data=dat, aes(y=LONGEV, x=THORAX))+theme_few()+facet_wrap(~TREATMEN)

## all together

ggplot()+geom_point(data=dat, aes(y=LONGEV, x=THORAX, color=as.factor(TREATMEN)))+theme_few()

## with lines

ggplot()+geom_point(data=dat, aes(y=LONGEV, x=THORAX, color=as.factor(TREATMEN)))+theme_few()+geom_smooth(data=dat, aes(y=LONGEV, x=THORAX, color=as.factor(TREATMEN)), method="lm")