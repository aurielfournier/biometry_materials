# from https://stats.stackexchange.com/questions/141279/manova-multiple-comparisons-with-equivalence-testing

library(lsmeans)
# Use the `oranges` dataset in `lsmeans` package.
# multivariate linear model
oranges.mlm <- lm(cbind(sales1,sales2) ~ price1 + price2 + day + store,
                  data = oranges)
# Get the least square means
oranges.Vlsm <- lsmeans(oranges.mlm, "store")
# Multiple comparisons with fdr p value adjustment
test(contrast(oranges.Vlsm, "pairwise"), side = "=",  adjust = "fdr")
# With threshold spcified
test(contrast(oranges.Vlsm, "pairwise"), side = "=",  adjust = "fdr", delta = 0.25)