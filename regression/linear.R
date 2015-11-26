print("-> linear")

r_linearModel <- lm(Y ~ (X), dataset_training)


predictedY <- predict(r_linearModel, dataset_training)
residual_error <- dataset_training$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY

print(rmse(residual_error))

predictedY <- predict(r_linearModel, dataset_test)
residual_error <- dataset_test$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY

print(rmse(residual_error))


#First plot with green line
line <- predict(r_linearModel, dataset)
plot(x <- dataset_training$X, y <- dataset_training$Y, pch=16, xlim = c(0,1431), xlab="Day", ylab="minute-average active power")
lines(dataset$X, line, col = "red", pch=4)

title(main="Linear Regression: Result")

#Cleaning environment
rm(x)
rm(y)
rm(line)