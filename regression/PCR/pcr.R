print("-> Principal Component Regression (PCR)")

library(pls)

r_pcr <- pcr(Y ~ X, data=dataset_training, validation="CV")

#summary(fit)

predictedY <- predict(r_pcr, dataset_training)
residual_error <- dataset_training$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY
  
print(rmse(residual_error))

predictedY <- predict(r_pcr, dataset_test)
residual_error <- dataset_test$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY
  
print(rmse(residual_error))

plot(x <- dataset_training$X, y <- dataset_training$Y, pch=16, xlim = c(0,1431), xlab="Day", ylab="minute-average active power")
  title(main="Principal Component Regression")
  lines(dataset$X, predict(r_pcr, dataset), col = "red", pch=4)

#Cleaning environment
rm(x)
rm(y)