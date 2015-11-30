library(e1071)

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
dataset$DiaHora <- (dataset$Dia * 24) + dataset$Hora
names(dataset) <- c("Y", "Sub1", "Sub2", "Sub3", "Dia", "Hora", "X")

plot_X_axis <- "(Day * 24) + Hour"
plot_Y_axis <- "Global Active Power"

dataset_training <- dataset[1:25601,]
dataset_test <- dataset[25602:34135,]

#Sum of squared errors
#
source('regression/linear.R')
endmethod()
#

#SVR using linear kernel
#
source('regression/SVR/epsilon_linear.R')
toprintmse(r_e1071_svr_eps_lin$MSE)
endmethod()

source('regression/SVR/nu_linear.R')
toprintmse(r_e1071_svr_nu_lin$MSE)
endmethod()
#

#SVR using polynomial kernel
#
source('regression/SVR/epsilon_polynomial.R')
toprintmse(r_e1071_svr_eps_pol$MSE)
endmethod()

source('regression/SVR/nu_polynomial.R')
toprintmse(r_e1071_svr_nu_pol$MSE)
endmethod()
#

#SVR using radial kernel
#
source('regression/SVR/epsilon_radial.R')
toprintmse(r_e1071_svr_eps_rad$MSE)
endmethod()

source('regression/SVR/nu_radial.R')
toprintmse(r_e1071_svr_nu_rad$MSE)
endmethod()
#

#SVR using sigmoid kernel
#
source('regression/SVR/epsilon_sigmoid.R')
toprintmse(r_e1071_svr_eps_sig$MSE)
endmethod()

source('regression/SVR/nu_sigmoid.R')
toprintmse(r_e1071_svr_nu_sig$MSE)
endmethod()
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

rm(plot_X_axis)
rm(plot_Y_axis)