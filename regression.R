library(e1071)

#Using the dataset V1

dataset_test <- dataset_v1_test
dataset <- dataset_v1

source('regression/linear.R')

#http://wiki.eigenvector.com/index.php?title=Svm
source('regression/SVR/epsilon_linear.R')
source('regression/SVR/nu_linear.R')

source('regression/SVR/epsilon_radial.R')
source('regression/SVR/nu_radial.R')

source('regression/SVR/epsilon_polynomial.R')
source('regression/SVR/nu_polynomial.R')

#source('regression/SVR/epsilon_sigmoid.R')
#source('regression/SVR/nu_sigmoid.R')









# Cleaning environment
rm(dataset_test)
rm(dataset)