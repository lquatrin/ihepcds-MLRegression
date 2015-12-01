print("-> nu_radial")

if(require(e1071)){
  r_e1071_svr_nu_rad <- svm(formula = svm_formula ,
                         type = "nu-regression",
                         data = dataset_training,
                         cost = svm_cost,
                         
                         nu = svm_nu,
                         
                         cross = k_cross_valid_svm_setup,
                         
                         kernel = svm_kernel,
                         gamma = svm_gamma)

  predictedY <- predict(r_e1071_svr_nu_rad, dataset_training)
  residual_error <- dataset_training$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY
  
  print(rmse(residual_error))

  predictedY <- predict(r_e1071_svr_nu_rad, dataset_test)
  residual_error <- dataset_test$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY
  
  print(rmse(residual_error))
    
  plot(x <- dataset_training$X, y <- dataset_training$Y, 
       pch='*', xlim = c(0,nrow(dataset)), xlab=plot_X_axis, ylab=plot_Y_axis)
  title(main=svm_title_plot)
  lines(dataset$X, predict(r_e1071_svr_nu_rad, dataset), col = "red", pch=4)
}

#Cleaning environment
rm(x)
rm(y)
rm(predictedY)
rm(residual_error)