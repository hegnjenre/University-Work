require("DescTools")
require("e1071")
require("modeest")
data("iris")

speciesData <- table(iris$Species)

barplot(speciesData,
        xlab="Species",
        ylab="Frequency",
        col=c("red","green","blue"),
        ylim=c(0,60))

hist(iris$Sepal.Width,
     xlab="Sepal Width (cm)",
     ylab="Frequency",
     main="Histogram",
     col="lightblue",
     xlim=c(1.5, 4.9))

boxplot(iris$Petal.Length ~ iris$Species,
        ylab="Petal Length",
        xlab="Species")

plot(iris$Petal.Length,
     iris$Petal.Width,
     xlab="Length",
     ylab="Width")