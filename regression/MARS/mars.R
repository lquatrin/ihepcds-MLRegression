print("-> Multivariate Adaptive Regression Splines")

library(earth)
library(plotmo)
library(plotrix)
library(TeachingDemos)

# load data
r_mars <- earth(Y ~ X, dataset_training)

# summarize the fit
#summary(fit)

# summarize the importance of input variables
#evimp(fit)

predictedY <- predict(r_mars, dataset_training$X)
residual_error <- dataset_training$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY

print(rmse(residual_error))

predictedY <- predict(r_mars, dataset_test$X)
residual_error <- dataset_test$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY

print(rmse(residual_error))

#First plot with green line
line <- predict(r_mars, dataset)
plot(x <- dataset_training$X, y <- dataset_training$Y, pch=16, xlim = c(0,1431), xlab="Day", ylab="minute-average active power")
lines(dataset$X, line, col = "red", pch=4)

title(main="Multivariate Adaptive Regression Splines")

#Cleaning environment
rm(x)
rm(y)
rm(line)