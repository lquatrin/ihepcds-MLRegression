print("-> epsilon_radial")

if(require(e1071)){
  r_svr_e1071_rad <- svm(formula = Y ~ X ,
                         type = "eps-regression",
                         data = dataset_training,
                         cost = 10,
                         
                         epsilon = 0.1, 
                         
                         cross = k_cross_valid_svm_setup,
                         
                         kernel = "radial",
                         gamma = 4)

  predictedY <- predict(r_svr_e1071_rad, dataset_training)
  residual_error <- dataset_training$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY
  
  print(rmse(residual_error))
  
  predictedY <- predict(r_svr_e1071_rad, dataset_test)
  residual_error <- dataset_test$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY
  
  print(rmse(residual_error))
  
  plot(x <- dataset_training$X, y <- dataset_training$Y, pch=16, xlim = c(0,1431), xlab="Day", ylab="minute-average active power")
  title(main="SVM Epsilon Radial Regression")
  lines(dataset$X, predict(r_svr_e1071_rad, dataset), col = "red", pch=4)
}

#Cleaning environment
rm(x)
rm(y)