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


