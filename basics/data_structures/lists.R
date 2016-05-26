# create a list of named items
a <- list(aa=1, bb=2, cc=3)
a
# $aa
# [1] 1
# $bb
# [1] 2
# $cc
# [1] 3
a$aa
# [1] 1

# add a named item to a list
a$dd=4
a
# $aa
# [1] 1
# 
# $bb
# [1] 2
# 
# $cc
# [1] 3
# 
# $dd
# [1] 4

# Add elements to a list
dfsMod <- list()
for (a in dfs) {
  a [,colsToConvertFactorsToNumeric] <- lapply( a[,colsToConvertFactorsToNumeric], function(y) as.numeric(as.character(y)))
  dfsMod[[length(dfsMod)+1]] <- a
}
str(dfsMod)
