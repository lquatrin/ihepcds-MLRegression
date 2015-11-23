#http://pingax.com/linear-regression-with-r-step-by-step-implementation-part-1/
#http://pingax.com/linear-regression-with-r-step-by-step-implementation-part-2/

#Based on Gradient Convergence

#Regression: Find the correct values of n Thetas (t1, t2)
create_linear_regression <- function(ldata, alpha, iterations, epsilont = 0.0000001)
{
  #dependent variable
  y <- data$Y
  #independent variable
  x <- data$X
  
  #Add many ones into x
  x <- cbind(1,x)
  #Initialize theta vector (coeficients)
  theta <- c(0,0)
  #Number of observations (samples)
  m <- nrow(x)
  #calculate initial cost
  cost <- sum (((x%*%theta)-y)^2)/(2*m)

  oldt <- c(0,0)
  #updating thetas using gradient update
  for (i in 1:iterations)
  {
    oldt[1] <- theta[1]
    oldt[2] <- theta[2]
    
    theta[1] <- theta[1] - alpha * (1/m) * sum(((x%*%theta)-y))
    theta[2] <- theta[2] - alpha * (1/m) * sum(((x%*%theta)-y)*x[,2])
    
    if(abs(oldt[1] - theta[1]) < epsilont && abs(oldt[2] - theta[2]) < epsilont) 
    {
      print("CreateLinearRegression: Accuracy reached")
      break
    }
    #print(cat("Theta1: ", theta[1], " | Theta2: ", theta[2]))
  }
  return (theta)
}

#Read data set
#data <- read.csv("regression.csv")
data <- dataset_1_md

#Creates a linear regression
#theta <- create_linear_regression(data, 0.001, 50000)

#Predict for areas of the 35,000 and 70,000 people
#predict1 <- c(1,3.5) %*% theta
#predict2 <- c(1,7) %*% theta

#compare with the lm function
model_lm_R <- lm(Y ~ (X), data)
