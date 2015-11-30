

createX <- function (i)
{
  return((as.numeric(dataset$Dia[i]) * 24.0) + as.numeric(dataset$Hora[i]))
}

x <- c(1:34135)
y <- dataset$Global

for (i in 1:34135 ) {
  x[i] <- createX(i)
}

plot(x, y, pch = "*", xlab = "(Day * 24) + Hour", ylab = "global")
title(main="electric power consumption")