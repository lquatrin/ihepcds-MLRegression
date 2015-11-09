#Examples of linear regression
#http://machinelearningmastery.com/linear-regression-in-r/
#Stats Package:
#http://stat.ethz.ch/R-manual/R-devel/library/stats/html/00Index.html

#1-Ordinary Least Squares (OLS) regression:
#Finds a linear model trying to minimize the sum of squared errors

#load data
data(longley)
# fit model
fit <- lm(Employed~., longley)
# summarize the fit
summary(fit)
# make predictions
predictions <- predict(fit, longley)
# summarize accuracy
rmse <- mean((longley$Employed - predictions)^2)
print(rmse)

#2-Stepwize Linear Regression 
#Find a subset of attributes to best perform the model

# load data
data(longley)
# fit model
base <- lm(Employed~., longley)
# summarize the fit
summary(base)
# perform step-wise feature selection
fit <- step(base)
# summarize the selected model
summary(fit)
# make predictions
predictions <- predict(fit, longley)
# summarize accuracy
rmse <- mean((longley$Employed - predictions)^2)
print(rmse)

#http://cran.r-project.org/web/packages/pls/index.html

#3-Principal Component Regression (PCR)
#creates a linear regression model using the outputs of a Principal Component Analysis (PCA)

# load the package
library(pls)
# load data
data(longley)
# fit model
fit <- pcr(Employed~., data=longley, validation="CV")
# summarize the fit
summary(fit)
# make predictions
predictions <- predict(fit, longley, ncomp=6)
# summarize accuracy
rmse <- mean((longley$Employed - predictions)^2)
print(rmse)

#4-Partial Least Squares Regression
# creates a linear model of the data in a transformed projection of problem space

# load the package
library(pls)
# load data
data(longley)
# fit model
fit <- plsr(Employed~., data=longley, validation="CV")
# summarize the fit
summary(fit)
# make predictions
predictions <- predict(fit, longley, ncomp=6)
# summarize accuracy
rmse <- mean((longley$Employed - predictions)^2)
print(rmse)

#Examples of non linear regression
#http://machinelearningmastery.com/non-linear-regression-in-r/
#1-Multivariate Adaptive Regression Splines

# load the package
library(earth)
# load data
data(longley)
# fit model
fit <- earth(Employed~., longley)
# summarize the fit
summary(fit)
# summarize the importance of input variables
evimp(fit)
# make predictions
predictions <- predict(fit, longley)
# summarize accuracy
rmse <- mean((longley$Employed - predictions)^2)
print(rmse)

#2-Support Vector Machine

# load the package
library(kernlab)
# load data
data(longley)
# fit model
fit <- ksvm(Employed~., longley)
# summarize the fit
summary(fit)
# make predictions
predictions <- predict(fit, longley)
# summarize accuracy
rmse <- mean((longley$Employed - predictions)^2)
print(rmse)

#3-k-Nearest Neighbor

# load the package
library(caret)
# load data
data(longley)
# fit model
fit <- knnreg(longley[,1:6], longley[,7], k=3)
# summarize the fit
summary(fit)
# make predictions
predictions <- predict(fit, longley[,1:6])
# summarize accuracy
rmse <- mean((longley$Employed - predictions)^2)
print(rmse)

#4-Neural Network

# load the package
library(nnet)
# load data
data(longley)
x <- longley[,1:6]
y <- longley[,7]
# fit model
fit <- nnet(Employed~., longley, size=12, maxit=500, linout=T, decay=0.01)
# summarize the fit
summary(fit)
# make predictions
predictions <- predict(fit, x, type="raw")
# summarize accuracy
rmse <- mean((y - predictions)^2)
print(rmse)