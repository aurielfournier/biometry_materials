dat <- dat[dat$STREAMNUM<=3,]

streams <- unique(as.character(dat$STREAM))
seasons <- unique(as.character(dat$SEASON))

list_of_covs <- list()

for(i in streams){
  for(j in seasons){
  list_of_covs[[paste0(i,j)]] <-  cov(dat[dat$SEASON==j&dat$STREAM==i,c("VOLUME","VELOCITY")])
  }
}