if(require(e1071)){
  r_e1071_svr_nu_lin <- svm(formula = Y ~ X ,
                         type = "nu-regression",
                         data = dataset_test,
                         cost = 10,
                         
                         nu = 0.5,
                         
                         kernel = "linear")

  plot(x <- dataset_test$X, y <- dataset_test$Y, pch=16, xlim = c(0,1431), xlab="Day", ylab="minute-average active power")
  title(main="SVM Nu Linear Regression: Training")
  lines(dataset$X, predict(r_e1071_nu_svr_rad, dataset), col = "red", pch=4)
}

#Cleaning environment
rm(x)
rm(y)