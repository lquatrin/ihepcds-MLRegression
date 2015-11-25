if(require(e1071)){
  r_svr_e1071_pol <- svm(formula = Y ~ X ,
                         type = "eps-regression",
                         data = dataset_test, 
                         cost = 1,
                         
                         epsilon = 0.1,
                         
                         kernel = "polynomial",
                         degree = 4,
                         gama = 1,
                         coef0 = 2)

  plot(x <- dataset_test$X, y <- dataset_test$Y, pch=16, xlim = c(0,1431), xlab="Day", ylab="minute-average active power")
  title(main="SVM Epsilon Polynomial Regression: Training")
  lines(dataset$X, predict(r_svr_e1071_pol, dataset), col = "red", pch=4)
}

#Cleaning environment
rm(x)
rm(y)