uni <- unique(dat$ZINC)

for(i in 1:length(uni)){
  print(uni[i])
  stem(dat[dat$ZINC==uni[i],]$DIVERSITY)
}