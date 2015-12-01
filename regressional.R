library(e1071)

dataset <- datasetbyday

rmse <- function(error)
{
  sqrt(mean(error^2))
}

endmethod <- function()
{
  print("---------------------")
}

k_cross_valid_svm_setup <- 1
print_mse <- FALSE

ren_dataset <- dataset
#dataset$DiaHora <- (dataset$Dia * 24) + dataset$Hora

names(dataset) <- c("Dia", "Global", "Sub1", "Sub2", "Sub3", "SubG")
dataset$X <- dataset$Dia

plot_X_axis <- "Day"

dataset_training <- dataset[1:1071,]
dataset_test <- dataset[1072:1251,]

dataset_training <- dataset[1:1251,]
dataset_test <- dataset[1252:1431,]

dataset_training$X <- dataset_training$Dia
dataset_test$X <- dataset_test$Dia

dataset_training$Y <- dataset_training$SubG
dataset_test$Y <- dataset_test$SubG
dataset$Y <- dataset$SubG

plot_Y_axis <- "Global - SubMeterings"
svm_formula <- SubG ~ Dia
svm_cost <- 1.0
svm_nu <- 0.4
svm_kernel <- "radial"
svm_gamma <- 4
svm_title_plot <- "SubGlobal Regression"
source('regression/SVR/nu_radial.R')
r_SubG <- r_e1071_svr_nu_rad

dataset_training$Y <- dataset_training$Sub3
dataset_test$Y <- dataset_test$Sub3
dataset$Y <- dataset$Sub3

plot_Y_axis <- "SubMetering 3"
svm_formula <- Sub3 ~ Dia
svm_cost <- 1.0
svm_nu <- 0.5
svm_kernel <- "radial"
svm_gamma <- 4
svm_title_plot <- "Sub3 Regression"
source('regression/SVR/nu_radial.R')
r_Sub3 <- r_e1071_svr_nu_rad

dataset_training$Y <- dataset_training$Sub2
dataset_test$Y <- dataset_test$Sub2
dataset$Y <- dataset$Sub2

plot_Y_axis <- "SubMetering 2"
svm_formula <- Sub2 ~ Dia
svm_cost <- 3.0
svm_nu <- 0.7
svm_kernel <- "radial"
svm_gamma <- 3
svm_title_plot <- "Sub2 Regression"
source('regression/SVR/nu_radial.R')
r_Sub2 <- r_e1071_svr_nu_rad
#source("regression/linear.R")
#r_Sub2 <- r_linear
  
dataset_training$Y <- dataset_training$Sub1
dataset_test$Y <- dataset_test$Sub1
dataset$Y <- dataset$Sub1

plot_Y_axis <- "SubMetering 1"
svm_formula <- Sub1 ~ Dia
svm_cost <- 1.0
svm_nu <- 0.5
svm_kernel <- "radial"
svm_gamma <- 3
svm_title_plot <- "Sub1 Regression"
source('regression/SVR/nu_radial.R')
r_Sub1 <- r_e1071_svr_nu_rad
#source("regression/linear.R")
#r_Sub1 <- r_linear

print("-> nu_ALL")

datasetpredtrain <- dataset_training
datasetpredtrain$Sub1 <- predict(r_Sub1, dataset_training)
datasetpredtrain$Sub2 <- predict(r_Sub2, dataset_training)
datasetpredtrain$Sub3 <- predict(r_Sub3, dataset_training)
datasetpredtrain$SubG <- predict(r_SubG, dataset_training)

predictedY <- c(1:nrow(datasetpredtrain))
vsize <- nrow(datasetpredtrain)
for (i in 1:vsize)
{
  predictedY[i] <- (datasetpredtrain$Sub1[i] + datasetpredtrain$Sub2[i] 
                    + datasetpredtrain$Sub3[i] + datasetpredtrain$SubG[i]) * (60/1000)
}
residual_error <- dataset_training$Global - predictedY

print(rmse(residual_error))

datasetpredtest <- dataset_test
datasetpredtest$Sub1 <- predict(r_Sub1, dataset_test)
datasetpredtest$Sub2 <- predict(r_Sub2, dataset_test)
datasetpredtest$Sub3 <- predict(r_Sub3, dataset_test)
datasetpredtest$SubG <- predict(r_SubG, dataset_test)

predictedY <- c(1:nrow(datasetpredtest))
vsize <- nrow(datasetpredtest)
for (i in 1:vsize)
{
  predictedY[i] <- (datasetpredtest$Sub1[i] + datasetpredtest$Sub2[i] 
                    + datasetpredtest$Sub3[i] + datasetpredtest$SubG[i]) * (60/1000)
}
residual_error <- dataset_test$Global - predictedY

print(rmse(residual_error))

datasetpred <- dataset

datasetpred$Sub1 <- predict(r_Sub1, dataset)
datasetpred$Sub2 <- predict(r_Sub2, dataset)
datasetpred$Sub3 <- predict(r_Sub3, dataset)
datasetpred$SubG <- predict(r_SubG, dataset)

plot_Y_axis <- "Global Active Power"
plot(x <- dataset_training$Dia, y <- dataset_training$Global,
     pch='*', xlim = c(0,nrow(dataset)), xlab=plot_X_axis, ylab=plot_Y_axis)
title(main="SVM with sub-meterings")
lines(dataset$Dia, predict(r_e1071_svr_all, datasetpred), col = "red", pch=4)

dataset <- ren_dataset 

# Cleaning environment
rm(dataset_training)
rm(dataset_test)
rm(ren_dataset)

rm(k_cross_valid_svm_setup)
rm(print_mse)
rm(svm_formula)

rm(rmse)
rm(endmethod)

rm(plot_X_axis)
rm(plot_Y_axis)

rm(svm_cost)
rm(svm_nu)
rm(svm_kernel)
rm(svm_gamma)