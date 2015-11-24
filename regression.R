library(e1071)

#Using the dataset V1

dataset_test <- dataset_v1_test
dataset <- dataset_v1

# Linear
source('regression/linear.R')

# SVR radial
source('regression/svmregression_radial.R')

# SVR polynomial
source('regression/svmregression_poly.R')










# Cleaning environment
rm(dataset_test)
rm(dataset)