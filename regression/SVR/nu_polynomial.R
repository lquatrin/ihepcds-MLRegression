rmse <- function(error)
{
  sqrt(mean(error^2))
}

if(require(e1071)){
  r_nu_svr_e1071_pol <- svm(formula = Y ~ X ,
                            type = "nu-regression",
                            data = dataset_test, 
                            cost = 1,
                            
                            nu = 0.5,
                            
                            kernel = "polynomial",
                            degree = 4,
                            gama = 1,
                            coef0 = 0)

  #predictedY <- predict(r_svr_e1071_pol, dataset_test)
  
  #error <- dataset_test$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY
  
  #svrPredictionRMSE <- rmse(error)  # 3.157061 
  
  #svr_tuneResult <- tune(svm, Y ~ X,  data = dataset_test
  #                   , ranges = list(epsilon = seq(0,1,0.5), cost = 2^(2:9))
  #)

  r_nu_svr_e1071_pol_tuned <- 
    r_nu_svr_e1071_pol
    #svr_tuneResult$best.model

  #First plot
  plot(x <- dataset_test$X, y <- dataset_test$Y, pch=16, xlim = c(0,1431), xlab="Day", ylab="minute-average active power")
  #lines(dataset_test$X, predict(r_svr_e1071_pol_tuned, dataset_test), col = "green", pch=4)
  title(main="SVM Nu Polynomial Regression: Training")

  #Second plot
  #plot(x <- dataset$X, y <- dataset$Y, pch=16, xlim = c(0,1431), xlab="Day", ylab="minute-average active power")
  lines(dataset$X, predict(r_nu_svr_e1071_pol_tuned, dataset), col = "red", pch=4)
  #title(main="SVM Polynomial Regression: Result")
}

#Cleaning environment
rm(x)
rm(y)
rm(rmse)
#rm(error)
#rm(svr_tuneResult)
#rm(svrPredictionRMSE)
#rm(predictedY)