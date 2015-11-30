print("-> linear")

r_linear <- lm(Y ~ (X), dataset_training)


predictedY <- predict(r_linear, dataset_training)
residual_error <- dataset_training$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY

print(rmse(residual_error))

predictedY <- predict(r_linear, dataset_test)
residual_error <- dataset_test$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY

print(rmse(residual_error))


#First plot with green line
line <- predict(r_linear, dataset)
plot(x <- dataset_training$X, y <- dataset_training$Y, pch='*', xlim = c(0,nrow(dataset)), xlab=plot_X_axis, ylab=plot_Y_axis)
lines(dataset$X, line, col = "red", pch=4)

title(main="Linear Regression")

#Cleaning environment
rm(x)
rm(y)
rm(line)
rm(predictedY)
rm(residual_error)