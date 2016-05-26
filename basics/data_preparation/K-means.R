# K-means clustering is the most popular partitioning method. It requires the analyst to specify the number of clusters to extract. 
# A plot of the within groups sum of squares by number of clusters extracted can help determine the appropriate number of clusters. 
# The analyst looks for a bend in the plot similar to a scree test in factor analysis. See Everitt & Hothorn (pg. 251).
# Determine number of clusters
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(mydata, 
                                     centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares")
# K-Means Cluster Analysis
fit <- kmeans(mydata, 5) # 5 cluster solution
# get cluster means 
aggregate(mydata,by=list(fit$cluster),FUN=mean)
# append cluster assignment
mydata <- data.frame(mydata, fit$cluster)
# A robust version of K-means based on mediods can be invoked by using pam( ) instead of kmeans( ). 
# The function pamk( ) in the fpc package is a wrapper for pam that also prints the suggested number of clusters based on optimum 
# average silhouette width.


# References:
# http://www.statmethods.net/advstats/cluster.html