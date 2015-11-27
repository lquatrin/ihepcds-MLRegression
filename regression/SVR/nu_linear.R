print("-> nu_linear")

if(require(e1071)){
  r_e1071_svr_nu_lin <- svm(formula = Y ~ X ,
                         type = "nu-regression",
                         data = dataset_training,
                         cost = 10,
                         
                         nu = 0.5,
                         
                         cross = k_cross_valid_svm_setup,
                         
                         kernel = "linear")

  predictedY <- predict(r_e1071_svr_nu_lin, dataset_training)
  residual_error <- dataset_training$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY
  
  print(rmse(residual_error))
  
  predictedY <- predict(r_e1071_svr_nu_lin, dataset_test)
  residual_error <- dataset_test$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY
  
  print(rmse(residual_error))
  
  
  plot(x <- dataset_training$X, y <- dataset_training$Y, pch=16, xlim = c(0,1431), xlab="Day", ylab="minute-average active power")
  title(main="SVM Nu Linear Regression: Training")
  lines(dataset$X, predict(r_e1071_svr_nu_lin, dataset), col = "red", pch=4)
}

#Cleaning environment
rm(x)
rm(y)