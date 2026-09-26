require("DescTools")
require("e1071")
require("modeest")

data1 <- read.csv("gas_bill.csv")

dataMean <- mean(data1$cost)
print(dataMean)

data2 <- read.csv("influenza_g.csv")
data21 <- c(12,25,36,39,49,51,64,67,68,73,78,80,80)

dataMedian <- median(data2$percent)
print(dataMedian)

data3 <- c(5.4,8.9)
data4 <- read.csv("sampledata_a.csv")
data5 <- read.csv("skewness_l.csv")

Qdata <- quantile(data4$sample, 0.80, type=6)
print(Qdata)
IQRdata <- IQR(data4$sample, type=6)
print(IQRdata)
SDdata <- sd(data3)
print(SDdata)
Vardata <- var(data3)
print(Vardata)
Skewdata <- skewness(data5$sample)
print(Skewdata)

