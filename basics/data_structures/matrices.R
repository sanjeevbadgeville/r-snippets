# Create a 2-row, 3-column matrix with named headings
data <- c(1, 2, 3, 4, 5, 6)
# [1] 1 2 3 4 5 6
headings <- list(NULL, c("a","b","c"))
headings
# [[1]]
# NULL
# 
# [[2]]
# [1] "a" "b" "c"
m <- matrix(data, nrow=2, ncol=3, byrow=TRUE, dimnames=headings)
m
#      a b c
# [1,] 1 2 3
# [2,] 4 5 6