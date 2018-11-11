## Cluster analysis of the new Old Faithful datasets

set.seed(190)

library(dbscan)

oldFaithful <- read.csv("./Data/geyserTime.csv")

dbscanGeyser1 <- dbscan(oldFaithful, eps = 2, minPts = 30) ## We see that due to the major difference between the two dimensions, that it is difficult to get the two parts to cluster separately without excluding many of the points in each.

plot(oldFaithful, col = colours()[dbscanGeyser1$cluster + 51])

## We can do better by transforming the data or weighting the dimensions differently, e.g.

oldFaithful$Wait.Time.Transformed.to.Hrs <- oldFaithful$Wait.Time.since.Previous.Eruption..min./60

## I re-record the old faithful times in hours but you can use alternative transformations since there's nothing less arbitrary about hours vs another unit of time.

dbscanGeyser <- dbscan(cbind(oldFaithful$Eruption.Length..min., oldFaithful$Wait.Time.Transformed.to.Hrs), eps = 0.5)

plot(oldFaithful[ , c(1,3)], col = colours()[dbscanGeyser$cluster+60], main = "Clustering according to DBSCAN of Old Faithful")

## Much better.

kmeansGeyser1 <- kmeans(oldFaithful[ , 1:2], centers = 2)

plot(oldFaithful[ , c(1,3)], col = colours()[kmeansGeyser1$cluster+60], xlab = "Eruption Length (min)", ylab = "Wait Time since Previous Eruption (hrs)", main = "Clustering according to k-Means of Old Faithful")

## k-Means doesn't work so well with the untransformed data either.

kmeansGeyser <- kmeans(oldFaithful[ , c(1,3)], centers = 2)

plot(oldFaithful[ , c(1,3)], col = colours()[kmeansGeyser$cluster+60], xlab = "Eruption Length (min)", ylab = "Wait Time since Previous Eruption (hrs)", main = "Clustering according to k-Means of Old Faithful")

## With the transformed data it does give us what we're looking for.  k-Means has other failings, for instance it classifies all the eruption length outliers as belonging to the nearest group.
