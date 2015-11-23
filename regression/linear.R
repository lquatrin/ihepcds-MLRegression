r_linearModel <- lm(Y ~ (X), dataset_test)

#First plot with green line
line <- predict(r_linearModel, dataset_test)
plot(x <- dataset_test$X, y <- dataset_test$Y, pch=16, xlim = c(0,1431), xlab="Day", ylab="minute-average active power")
lines(dataset_test$X, line, col = "green", pch=4)

title(main="Linear Regression: Training")

#Second plot with red line
line <- predict(r_linearModel, dataset)
plot(x <- dataset$X, y <- dataset$Y, pch=16, xlim = c(0,1431), xlab="Day", ylab="minute-average active power")
lines(dataset$X, line, col = "red", pch=4)

title(main="Linear Regression: Result")

#Cleaning environment
rm(x)
rm(y)
rm(line)