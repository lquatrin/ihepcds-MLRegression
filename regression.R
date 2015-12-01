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

toprintmse <- function(value)
{
  if (print_mse)
  {
    print(value)
  }
}

k_cross_valid_svm_setup <- 1
print_mse <- FALSE

ren_dataset <- dataset
#dataset$DiaHora <- (dataset$Dia * 24) + dataset$Hora
id_y <- 3
names(dataset) <- c("X", "Global", "Sub1", "Y", "Sub3", "SubG")

plot_X_axis <- "Day"
plot_Y_axis <- "Global Active Power"

dataset_training <- dataset[1:1251,]
dataset_test <- dataset[1252:1431,]

#Sum of squared errors
#
source('regression/linear.R')
summary(r_linear)
endmethod()
#


svm_formula <- Y ~ X

#SVR using linear kernel
#
#source('regression/SVR/epsilon_linear.R')
#toprintmse(r_e1071_svr_eps_lin$MSE)
#endmethod()

#source('regression/SVR/nu_linear.R')
#toprintmse(r_e1071_svr_nu_lin$MSE)
#endmethod()
#

#SVR using polynomial kernel
#
#source('regression/SVR/epsilon_polynomial.R')
#toprintmse(r_e1071_svr_eps_pol$MSE)
#endmethod()

#source('regression/SVR/nu_polynomial.R')
#toprintmse(r_e1071_svr_nu_pol$MSE)
#endmethod()
#

#SVR using radial kernel
#
if (id_y == 1 || id_y == 4)
{
  svm_cost <- 1.0
  svm_eps <- 0.01
  svm_kernel <- "radial"
  svm_gamma <- 3
}
if (id_y == 3)
{
  svm_cost <- 1.0
  svm_eps <- 0.5
  svm_kernel <- "radial"
  svm_gamma <- 1
}
if (id_y == 5)
{
  svm_cost <- 1.0
  svm_eps <- 0.1
  svm_kernel <- "radial"
  svm_gamma <- 3
}
source('regression/SVR/epsilon_radial.R')
toprintmse(r_e1071_svr_eps_rad$MSE)
endmethod()

if (id_y == 1 || id_y == 4)
{
  svm_cost <- 1.0
  svm_nu <- 0.5
  svm_kernel <- "radial"
  svm_gamma <- 3
}
if (id_y == 3)
{
  svm_cost <- 1.0
  svm_nu <- 0.5
  svm_kernel <- "radial"
  svm_gamma <- 3
}
if (id_y == 5)
{
  svm_cost <- 1.0
  svm_nu <- 0.6
  svm_kernel <- "radial"
  svm_gamma <- 3
}
source('regression/SVR/nu_radial.R')
toprintmse(r_e1071_svr_nu_rad$MSE)
endmethod()
#

#SVR using sigmoid kernel
#
#source('regression/SVR/epsilon_sigmoid.R')
#toprintmse(r_e1071_svr_eps_sig$MSE)
#endmethod()

#source('regression/SVR/nu_sigmoid.R')
#toprintmse(r_e1071_svr_nu_sig$MSE)
#endmethod()
#

#NON LINEAR REGRESSION

#Neural Network
#http://machinelearningmastery.com/non-linear-regression-in-r/
#source('regression/NNet/nnet.R')
#endmethod()

#Multivariate Adaptive Regression Splines
#source('regression/MARS/mars.R')
#endmethod()

#k-Nearest Neighbor
#source('regression/kNN/kNN.R')
#endmethod()

#LINEAR REGRESSION

#Principal Component Regression (PCR)
#source('regression/PCR/pcr.R')
#endmethod()

#Partial Least Squares Regression
# creates a linear model of the data in a transformed projection of problem space
#source('regression/PLSR/plsr.R')
#endmethod()

dataset <- ren_dataset 

# Cleaning environment
rm(dataset_training)
rm(dataset_test)
rm(ren_dataset)

rm(k_cross_valid_svm_setup)
rm(print_mse)

rm(rmse)
rm(endmethod)
rm(toprintmse)

rm(svm_formula)

rm(plot_X_axis)
rm(plot_Y_axis)

rm(svm_cost)
rm(svm_nu)
rm(svm_eps)
rm(svm_kernel)
rm(svm_gamma)