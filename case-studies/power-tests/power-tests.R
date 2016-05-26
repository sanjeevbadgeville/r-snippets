# 
# ggplot2 docs completely remade in D3.js
# Posted: 25 May 2016 11:46 PM PDT
# (This article was first published on R – Modern Data, and kindly contributed to R-bloggers)
# Carson Sievert from Plotly recreated Hadley Wickam’s entire ggplot2 documentation using Plotly’s open-source ggplotly converter – http://ropensci.github.io/plotly/ggplot2/. This makes every ggplot2 graph interactive and drawn in D3.js !
#   
#   position_jitterdodge
# 
# scale_color_brewer
# 
# stat_summary_hex
# 
# geom_violin
# 
# geom_smooth
# 
# geom_polygon
# 
# geom_point
# 
# Here are some further resources to help you get started with ggplotly()
# 
# Plotly’s R API
# Plotly’s ggplot2 converter
# R API documentation
# To leave a comment for the author, please follow the link and comment on their blog: R – Modern Data.
# R-bloggers.com offers daily e-mail updates about R news and tutorials on topics such as: Data science, Big Data, R jobs, visualization (ggplot2, Boxplots, maps, animation), programming (RStudio, Sweave, LaTeX, SQL, Eclipse, git, hadoop, Web Scraping) statistics (regression, PCA, time series, trading) and more...
# 
# Power Curves in R Using Plotly ggplot2 Library
# Posted: 25 May 2016 11:02 PM PDT
# (This article was first published on R – Modern Data, and kindly contributed to R-bloggers)
# When performing Student’s t-test to compare the difference in means between two groups, it is a useful exercise to determine the effect of unequal sample sizes in the comparison groups on power. Formally, power can be defined as the probability of rejecting the null hypothesis when the alternative hypothesis is true. Informally, power is the ability of a statistical test to detect an effect, if the effect actually exists. Large imbalances generally will not have adequate statistical power to detect even large effect sizes associated with a factor, leading to a high Type II error rate.
# 
# To jusity this reasoning I performed a power analysis for different group sizes. I considered the following group sizes, where n1 are the number of subjects in group 1 and n2 are the number of subjects in group 2:
#   
#   n1 = 28, n2 = 1406: n1 represents 2% of the entire sample size of 1434
# n1 = 144, n2 = 1290: n1 represents 10% of the entire sample size of 1434
# n1 = 287, n2 = 1147: n1 represents 20% of the entire sample size of 1434
# n1 = 430, n2 = 1004: n1 represents 30% of the entire sample size of 1434
# n1 = 574, n2 = 860: n1 represents 40% of the entire sample size of 1434
# n1 = 717, n2 = 717: equal size groups (this is optimal because it leads to the highest power for a given effect size)
# In the figure below I plotted the power curves for the t-test, as a function of the effect size, assuming a Type I error rate of 5%. Comparing different power curves (based on the sample size of each group) on the same plot, is a useful visual representation of this analysis. We also plot a horizontal dashed line at an acceptable power level of 80%, and a vertical line at the effect size that would have to be present in our data to achieve 80% power. We see that the effect size must be greater than 0.54 to attain an acceptable power level given highly imbalanced group sizes of n1 = 28 and n2 = 1406, compared to all other scenarios that lead to 100% power.

needs(pwr) # for power calcs
needs(dplyr) # for data manipulation
needs(tidyr) # for data manipulation
needs(ggplot2) # for plotting power curves
needs(plotly) # for interactive power curves

# Generate power calculations
ptab <- cbind(NULL, NULL)       

for (i in seq(0,1, length.out = 200)){
  pwrt1 <- pwr.t2n.test(n1 = 28, n2 = 1406, 
                        sig.level = 0.05, power = NULL, 
                        d = i, alternative="two.sided")
  pwrt2 <- pwr.t2n.test(n1 = 144, n2 = 1290, 
                        sig.level = 0.05, power = NULL, 
                        d = i, alternative="two.sided")
  pwrt3 <- pwr.t2n.test(n1 = 287, n2 = 1147, 
                        sig.level = 0.05, power = NULL, 
                        d = i, alternative="two.sided")
  pwrt4 <- pwr.t2n.test(n1 = 430, n2 = 1004, 
                        sig.level = 0.05, power = NULL, 
                        d = i, alternative="two.sided")
  pwrt5 <- pwr.t2n.test(n1 = 574, n2 = 860, 
                        sig.level = 0.05, power = NULL, 
                        d = i, alternative="two.sided")
  pwrt6 <- pwr.t2n.test(n1 = 717, n2 = 717, 
                        sig.level = 0.05, power = NULL, 
                        d = i, alternative="two.sided")
  ptab <- rbind(ptab, cbind(pwrt1$d, pwrt1$power,
                            pwrt2$d, pwrt2$power,
                            pwrt3$d, pwrt3$power,
                            pwrt4$d, pwrt4$power,
                            pwrt5$d, pwrt5$power,
                            pwrt6$d, pwrt6$power))
}

ptab <- cbind(seq_len(nrow(ptab)), ptab)

colnames(ptab) <- c("id","n1=28, n2=1406.effect size","n1=28, n2=1406.power",
                    "n1=144, n2=1290.effect size","n1=144, n2=1290.power",
                    "n1=287, n2=1147.effect size","n1=287, n2=1147.power",
                    "n1=430, n2=1004.effect size","n1=430, n2=1004.power",
                    "n1=574, n2=860.effect size","n1=574, n2=860.power",
                    "n1=717, n2=717.effect size","n1=717, n2=717.power")

# get data into right format for ggplot2
temp <- ptab %>%
  as.data.frame() %>%
  tidyr::gather(key = name, value = val, 2:13) %>%
  tidyr::separate(col = name, into = c("group", "var"), sep = "\\.") %>%
  tidyr::spread(key = var, value = val)

# factor group
temp$group <- factor(temp$group, 
                     levels = c("n1=28, n2=1406", "n1=144, n2=1290", 
                                "n1=287, n2=1147", "n1=430, n2=1004",
                                "n1=574, n2=860", "n1=717, n2=717"))


# plot
p <- ggplot(temp, aes(x = `effect size`, y = power, color = group)) +
geom_line(size=2) + 
  theme_bw() + 
  theme(axis.text=element_text(size=14), 
        axis.title=element_text(size=14), 
        legend.text=element_text(size=14)) +
  geom_vline(xintercept = .54, linetype = 2) +
  geom_hline(yintercept = 0.80, linetype = 2)

# so simple to make interactive plots
plotly::ggplotly(p)

