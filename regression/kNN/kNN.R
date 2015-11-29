print("-> k-Nearest Neighbor")

library(caret)

r_kNN <- knnreg(Y ~ X, dataset_training, k=3) # or [,x1:x2]

#summary(fit)

predictedY <- predict(r_kNN, dataset_training)
residual_error <- dataset_training$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY

print(rmse(residual_error))

predictedY <- predict(r_kNN, dataset_test)
residual_error <- dataset_test$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY

print(rmse(residual_error))

plot(x <- dataset_training$X, y <- dataset_training$Y, pch=16, xlim = c(0,1431), xlab="Day", ylab="minute-average active power")
lines(dataset_test$X, predictedY, col = "red", pch=4)


#Cleaning environment
rm(x)
rm(y)