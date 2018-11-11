computeTimeDiff <- function(first, second) {
  hourMin <- strsplit(c(first, second), split = ":")
  hourMin[[1]] <- as.integer(hourMin[[1]][1])*60 + as.integer(hourMin[[1]][2])
  hourMin[[2]] <- as.integer(hourMin[[2]][1])*60 + as.integer(hourMin[[2]][2])
  difference <- hourMin[[2]] - hourMin[[1]]
  difference
}

computeDecMin <- function(minsec) {
  if (is.na(minsec)) {
    return(NA)
  }
  if (grepl("L", minsec)) {
    minsec <- gsub("L", "", minsec)
  }
  if (grepl("~", minsec)) {
    minsec <- gsub("~", "", minsec)
  }
  if (minsec == "" | grepl(">", minsec) | grepl("<", minsec)) {
    return(NA)
  }
  minSec <- strsplit(minsec, split = ":")
  return(as.numeric(minSec[[1]][1]) + (as.numeric(minSec[[1]][2])/60))
}

wranglingOldFaithful <- read.csv(paste0("./Data/log2001.csv"), stringsAsFactors = F)
nameVec <- unname(wranglingOldFaithful[27, ])[-(10:12)]
wranglingOldFaithful <- wranglingOldFaithful[29:nrow(wranglingOldFaithful), -(10:12)]
colnames(wranglingOldFaithful) <- nameVec
  
wranglingOldFaithful <- wranglingOldFaithful[wranglingOldFaithful$Geyser == "Old Faithful", ]
  
delta <- rep(NA, nrow(wranglingOldFaithful))
  
for (i in seq_len(nrow(wranglingOldFaithful))) {
  delta[i+1] <- computeTimeDiff(wranglingOldFaithful$Time[i], wranglingOldFaithful$Time[i+1])
}
  
delta <- c(-99, delta)
  
wranglingOldFaithful <- wranglingOldFaithful[!is.na(delta) & delta > 0 & delta < 140, ]
  
delta <- delta[!is.na(delta) & delta > 0 & delta < 140]
  
duration <- rep(NA, length(wranglingOldFaithful$Duration))
  
for (i in seq_len(length(duration))) {
  duration[i] <- computeDecMin(wranglingOldFaithful$Duration[i])
}

## There are eight durations recorded as high as 15, and all higher than 6, it might be worthwhile to exclude those outliers

finalfilter <- !is.na(duration)
  
duration <- duration[finalfilter]
delta <- delta[finalfilter]
  
wranglingOldFaithful <- cbind(duration, delta)

colnames(wranglingOldFaithful) <- c("Eruption Length (min)", "Wait Time since Previous Eruption (min)")


pdf("./DataVis/oldFaithful.pdf")

plot(wranglingOldFaithful, main = "Old Faithful Eruption Data")

dev.off()

outliersRemoved <- wranglingOldFaithful[wranglingOldFaithful[ , 1] < 6, ]

pdf("./DataVis/oldFaithfulOutliersRemoved.pdf")

plot(outliersRemoved[ , 1], jitter(outliersRemoved[ , 2]), main = "Old Faithful Eruption Data w/o Outliers", xlab = "Eruption Length (min)", ylab = "Wait Time since Previous Eruption (min)")

dev.off()

write.csv(wranglingOldFaithful, "./Data/geyserTime.csv", row.names = F)
