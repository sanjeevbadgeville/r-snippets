# create a new data frame
years <- c(1980, 1985, 1990)
scores <- c(34, 44, 83)

df <- data.frame(years, scores)
df
# years scores
# 1  1980     34
# 2  1985     44
# 3  1990     83

df[,1]
# [1] 1980 1985 1990

df$years
# [1] 1980 1985 1990
