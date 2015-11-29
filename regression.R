library(e1071)

#Using the dataset V1

rmse <- function(error)
{
  sqrt(mean(error^2))
}

endmethod <- function()
{
  print("---------------------")
}

k_cross_valid_svm_setup <- 10

#dataset <- dataset_v1
dataset_training <- dataset[1:1074,]
dataset_test <- dataset[1075:1431,]

source('regression/linear.R')
endmethod()

#http://wiki.eigenvector.com/index.php?title=Svm
source('regression/SVR/epsilon_linear.R')
print(r_e1071_svr_eps_lin$MSE)
endmethod()
source('regression/SVR/nu_linear.R')
print(r_e1071_svr_nu_lin$MSE)
endmethod()

source('regression/SVR/epsilon_radial.R')
print(r_svr_e1071_rad$MSE)
endmethod()
source('regression/SVR/nu_radial.R')
print(r_e1071_nu_svr_rad$MSE)
endmethod()

source('regression/SVR/epsilon_polynomial.R')
print(r_svr_e1071_pol$MSE)
endmethod()
source('regression/SVR/nu_polynomial.R')
print(r_nu_svr_e1071_pol$MSE)
endmethod()

source('regression/SVR/epsilon_sigmoid.R')
print(r_e1071_eps_svr_sig$MSE)
endmethod()
source('regression/SVR/nu_sigmoid.R')
print(r_e1071_nu_svr_sig$MSE)
endmethod()

# Cleaning environment
rm(dataset_test)
rm(dataset)
rm(rmse)