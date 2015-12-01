print("-> epsilon_polynomial")

if(require(e1071)){
  r_e1071_svr_eps_pol <- svm(formula = Y ~ X ,
                         type = "eps-regression",
                         data = dataset_training, 
                         cost = 1,
                         
                         epsilon = 0.05,
                         
                         cross = k_cross_valid_svm_setup,
                         
                         kernel = "polynomial",
                         degree = 3,
                         gama = 1,
                         coef0 = 3)

  predictedY <- predict(r_e1071_svr_eps_pol, dataset_training)
  residual_error <- dataset_training$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY
  
  print(rmse(residual_error))
  
  predictedY <- predict(r_e1071_svr_eps_pol, dataset_test)
  residual_error <- dataset_test$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY
  
  print(rmse(residual_error))
  
  plot(x <- dataset_training$X, y <- dataset_training$Y, 
       pch='*', xlim = c(0,nrow(dataset)), xlab=plot_X_axis, ylab=plot_Y_axis)
  title(main="SVM Epsilon Polynomial Regression")
  lines(dataset$X, predict(r_e1071_svr_eps_pol, dataset), col = "red", pch=4)
}

#Cleaning environment
rm(x)
rm(y)
rm(predictedY)
rm(residual_error)