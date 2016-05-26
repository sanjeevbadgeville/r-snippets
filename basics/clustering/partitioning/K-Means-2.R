# PCA is sensitive to the relative scaling of the original variables.
# https://en.wikipedia.org/wiki/Principal_component_analysis
# Relation between PCA and K-means clustering[edit]
# It was asserted in [31][32] that the relaxed solution of k-means clustering, specified by the cluster indicators, 
# is given by the PCA (principal component analysis) principal components, and the PCA subspace spanned by the principal directions 
# is identical to the cluster centroid subspace. However, that PCA is a useful relaxation of k-means clustering was not a new result
# (see, for example,[33]), and it is straightforward to uncover counterexamples to the statement that the cluster centroid subspace 
# is spanned by the principal directions.[34]
# 1) Acquire Data
# Diabetes data
#The diabetes data set is taken from the UCI machine learning database repository at:
# http://archive.ics.uci.edu/ml/datasets/Pima+Indians+Diabetes.
# 768 samples in the dataset
# 8 quantitative variables
# Load data into R as follows:
# set the working directory
setwd("./basics/clustering/datasets/")
# comma delimited data and no header for each variable
RawData <- read.table("./pima-indians-diabetes.data",sep = ",",header=FALSE)
# In RawData, the response variable is its last column; and the remaining columns 
# are the predictor variables.
responseY <- RawData[,dim(RawData)[2]]
predictorX <- RawData[,1:(dim(RawData)[2]-1)]
# For the convenience of visualization, we take the first two principle components as the new 
# feature variables and conduct k-means only on these two dimensional data.
pca <- princomp(predictorX, cor=T) # principal components analysis using correlation matrix
pc.comp <- pca$scores
pc.comp1 <- -1*pc.comp[,1] # principal component 1 scores (negated for convenience)
pc.comp2 <- -1*pc.comp[,2] # principal component 2 scores (negated for convenience)
# 2) K-Means
# In R, kmeans performs the K-means clustering analysis, ()$cluster provides the clustering 
# results and ()$centers provides the centroid vector (i.e., the mean) for each cluster.
X <- cbind(pc.comp1, pc.comp2)
cl <- kmeans(X,13)
cl$cluster
plot(pc.comp1, pc.comp2,col=cl$cluster)
points(cl$centers, pch=16)
# Take k = 13 (as in the lecture note) as the number of clusters in K-means analysis. Figure 1 
# shows the resulting scatter plot with different clusters in different colors. The solid black circles are the centers of the clusters.


