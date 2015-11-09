#setwd("E:/GitHub/SupportVectorRegression")
#E:/GitHub/ihepcds-MLRegression
#C:/Users/lquatrin/GitHub/ihepcds-MLRegression
library(e1071)

rescut <- resultado[8:34142,]

rmse <- function(error)
{
  sqrt(mean(error^2))
}

datetodiffnumber <- function(date1, hour, date_ref = as.Date("2006-12-16"))
{
  return((as.numeric(date1 - date_ref) * 24) + hour)
}

#RescaleData===============================
print("[Start] - Rescale the data")

vecsize = 1000#nrow(resultado)

plot_res = data.frame(X = c(1:vecsize), Y = c(1:vecsize ))
for (i in 1:vecsize ) {
  st = strsplit(rescut$Datas[i], ' ')[[1]]
  #st1 = strsplit(st[1], '-')[[1]]
  st2 = strsplit(st[2], ':')[[1]]
  
  plot_res$X[i] = datetodiffnumber(as.Date(st[1]), as.numeric(st2[1]))
  plot_res$Y[i] = rescut$SumEnergiaAtiva[i]
}
print("[-End-] - Rescale the data")
#RescaleData===============================

#LinearModel===============================
print("[Start] - Linear model")
model_lm_R <- lm(Y ~ (X), plot_res)
print("[-End-] - Linear model")
#LinearModel===============================

#SVR========================================
print("[Start] - Support Vector Regression")
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
print("[-End-] - Support Vector Regression")
#SVR========================================

#GraphicalResult============================
print("[Start] - Graphical results")
plot(plot_res, pch=16)
abline(model_lm_R, col = "red")
lines(plot_res$X, predictedY, col = "blue", pch=4)
lines(plot_res$X, tunedModelY, col = "green", pch=4)
print("[-End-] - Graphical results")
#GraphicalResult============================
