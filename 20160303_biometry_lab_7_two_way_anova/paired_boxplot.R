ggplot(data = q88,
       aes(x = as.factor(DENSITY), y = EGGS, fill = SEASON)) +
  geom_boxplot()