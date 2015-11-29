print("-> Neural Network")

# load the package
library(nnet)

# load data
X <- dataset_training[,1] # X can be [,1:3 or +]
Y <- dataset_training[,2]

# fit model
r_nnet <- nnet(Y ~ X, dataset_training, size=12, maxit=500, linout=T, decay=0.01)

# summarize the fit
#summary(fit)

predictedY <- predict(r_nnet, dataset_training, type="raw")
residual_error <- dataset_training$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY
  
print(rmse(residual_error))

predictedY <- predict(r_nnet, dataset_test, type="raw")
residual_error <- dataset_test$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY
  
print(rmse(residual_error))

plot(x <- dataset_training$X, y <- dataset_training$Y, pch=16, xlim = c(0,1431), xlab="Day", ylab="minute-average active power")
  title(main="Neural Network")
  lines(dataset$X, predict(r_nnet, dataset), col = "red", pch=4)

#Cleaning environment
rm(x)
rm(y)
rm(predictedY)
rm(X)
rm(Y)