if(require(e1071)){
  r_e1071_nu_svr_rad <- svm(formula = Y ~ X ,
                         type = "eps-regression",
                         data = dataset_test,
                         cost = 10,
                         
                         epsilon = 0.1,
                         
                         kernel = "sigmoid",
                         gamma = 0.005,
                         coef0 = 0)

  plot(x <- dataset_test$X, y <- dataset_test$Y, pch=16, xlim = c(0,1431), xlab="Day", ylab="minute-average active power")
  title(main="SVM Epsilon Sigmoid Regression: Training")
  lines(dataset$X, predict(r_e1071_nu_svr_rad, dataset), col = "red", pch=4)
}

#Cleaning environment
rm(x)
rm(y)