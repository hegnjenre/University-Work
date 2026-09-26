library("DescTools")
library("e1071")

heightsData <- read.csv("Heights_data.csv")

heightsMean <- mean(heightsData$height)
heightsMode <- Mode(heightsVector$height)
heightsMedian <- median(heightsVector$height)

print(heightsMean)
print(heightsMode)
print(heightsMedian)

