require("DescTools")

data1 = pnorm(0.152, mean=0.139, sd=0.01187)
data2 = pnorm(61, mean=60, sd=15)
data3 = pt(-2.7927, df=27)
data4 = read.csv("Olympics.csv")
data5 = qnorm(0.0413, mean=100, sd=15)
data6 = qnorm(0.4643, mean=-3, sd=4)
x = data4$Year
y = data4$Time

correlate = cor(x,y)

dataM = 1 - data1
data2M = 1 - data2
dataP = data2 - data1
dataOr = data1 + data2M
dataOr2 = data1 + data2
dataQM = 1 - data5
dataQ2M = 1 - data6

print(data1, digits=22)
print(data2, digits=22)
print(data3, digits=22)
print(data5, digits=22)
print(data6, digits=22)

print(dataM, digits=22)
print(data2M, digits=22)
print(dataP, digits=22)
print(dataOr, digits=22)
print(dataOr2, digits=22)
print(dataQM, digits=22)
print(dataQ2M, digits=22)

print(qchisq(0.1, 4))
print(correlate)
cor.test(x,y)
