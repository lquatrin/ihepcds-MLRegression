library(e1071)

plot_res <- dataset_1_md

rmse <- function(error)
{
  sqrt(mean(error^2))
}

if(require(e1071)){
  model_svm_e1071 <- svm(Y ~ X , plot_res)
  predictedY <- predict(model_svm_e1071, plot_res)
  
  error <- plot_res$Y - predictedY  # /!\ this time  svrModel$residuals  is not the same as data$Y - predictedY
  
  svrPredictionRMSE <- rmse(error)  # 3.157061 
  
  tuneResult <- tune(svm, Y ~ X,  data = plot_res
                     , ranges = list(epsilon = seq(0,1,0.5), cost = 2^(2:9))
  )
  
  tunedModel <- tuneResult$best.model
  tunedModelY <- predict(tunedModel, plot_res)
}

plot(x <- plot_res$X, y <- plot_res$Y, pch=16)
lines(plot_res$X, tunedModelY, col = "green", pch=4)

#> teste <- data.frame(X = seq(-3, 3, 0.5))
#> predict(tunedModel, teste)

> predict(tunedModel, teste)