qqnorm(dataset$Global)

dataset$DiaHora <- (dataset$Dia * 24) + dataset$Hora

install.packages("RcmdrPlugin.epack")