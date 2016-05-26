# Prepare Data
data <- na.omit(data) # listwise deletion of missing
data <- scale(data) # standardize variables

# How to Convert a Factor in R
# By Andrie de Vries and Joris Meys from R For Dummies
# Sometimes you need to explicitly convert factors to either text or numbers. To do this, you use the functions as.character() or as.numeric(). First, convert your directions vector into a factor called directions.factor (as you saw earlier):
#   
#   > directions <- c("North", "East", "South", "South")
# > directions.factor <- factor(directions)
# > directions.factor
# [1] North East South South
# Levels: East North South
# Use as.character() to convert a factor to a character vector:
#   
#   > as.character(directions.factor)
# [1] "North" "East" "South" "South"
# Use as.numeric() to convert a factor to a numeric vector. Note that this will return the numeric codes that correspond to the factor levels. For example, "East" corresponds to 1, "North" corresponds to 2, and so forth:
#   
#   > as.numeric(directions.factor)
# [1] 2 1 3 3
# Be very careful when you convert factors with numeric levels to a numeric vector. The results may not be what you expect.
# 
# For example, imagine you have a vector that indicates some test score results with the values c(9, 8, 10, 8, 9), which you convert to a factor:
#   
#   > numbers <- factor(c(9, 8, 10, 8, 9))
# To look at the internal representation of numbers, use str():
#   
#   > str(numbers)
# Factor w/ 3 levels "8","9","10": 2 1 3 1 2
# This indicates that R stores the values as c(2, 1, 3, 1, 2) with associated levels of c("8", "9", "10").
# 
# image0.jpg
# If you want to convert numbers to a character vector, the results are pretty much as you would expect:
#   
#   > as.character(numbers)
# [1] "9" "8" "10" "8" "9"
# However, if you simply use as. numeric(), your result is a vector of the internal level representations of your factor and not the original values:
#   
#   > as.numeric(numbers)
# [1] 2 1 3 1 2
# The R help at ?factor describes a solution to this problem. The solution is to index the levels by the factor itself, and then to convert to numeric:
#   
#   > as.numeric(as.character(numbers))
# [1] 9 8 10 8 9
# This is an example of nested functions in R, in which you pass the results of one function to a second function. Nested functions are a bit like the Russian nesting dolls, where each toy is inside the next:
#   
#   The inner function, as.character(numbers), contains the text c("8", "9", "10").
# 
# The outer function, as.numeric(...), does the final conversion to c(9, 8, 10, 8, 9).

# http://www.dummies.com/how-to/content/how-to-convert-a-factor-in-r.html
