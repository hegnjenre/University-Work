require("DescTools")

dataFile = read.csv("aptitude_j.csv")
dataS = dataFile$Scores
dataMean = mean(dataS)
dataSD = sd(dataS)
dataSE = dataSD/sqrt(length(dataS))
NNPercent = 2.57583
NFPercent = 1.95996

LCL = dataMean - (NFPercent*dataSE)
print(LCL)
UCL = dataMean + (NFPercent*dataSE)
print(UCL)


