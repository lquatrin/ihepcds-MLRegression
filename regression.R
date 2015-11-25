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

dataset <- dataset_v1
dataset_training <- dataset_v1_test
dataset_test <- dataset_v1[1075:1431,]

#source('regression/linear.R')

#http://wiki.eigenvector.com/index.php?title=Svm
#source('regression/SVR/epsilon_linear.R')
#source('regression/SVR/nu_linear.R')

source('regression/SVR/epsilon_radial.R')
endmethod()
source('regression/SVR/nu_radial.R')
endmethod()

#source('regression/SVR/epsilon_polynomial.R')
#source('regression/SVR/nu_polynomial.R')

#source('regression/SVR/epsilon_sigmoid.R')
#source('regression/SVR/nu_sigmoid.R')









# Cleaning environment
rm(dataset_test)
rm(dataset)
rm(rmse)