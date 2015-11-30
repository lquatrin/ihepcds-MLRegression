print("-> nu_polynomial")

if(require(e1071)){
  r_e1071_svr_nu_pol <- svm(formula = Y ~ X ,
                            type = "nu-regression",
                            data = dataset_training, 
                            cost = 1,
                            
                            nu = 0.5,
                            
                            cross = k_cross_valid_svm_setup,
                            
                            kernel = "polynomial",
                            degree = 4,
                            gama = 1,
                            coef0 = 0)

  predictedY <- predict(r_e1071_svr_nu_pol, dataset_training)
  residual_error <- dataset_training$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY
  
  print(rmse(residual_error))
  
  predictedY <- predict(r_e1071_svr_nu_pol, dataset_test)
  residual_error <- dataset_test$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY
  
  print(rmse(residual_error))
  
  plot(x <- dataset_training$X, y <- dataset_training$Y,
       pch='*', xlim = c(0,nrow(dataset)), xlab=plot_X_axis, ylab=plot_Y_axis)
  title(main="SVM Nu Polynomial Regression")
  lines(dataset$X, predict(r_e1071_svr_nu_pol, dataset), col = "red", pch=4)
}

#Cleaning environment
rm(x)
rm(y)
rm(predictedY)
rm(residual_error)