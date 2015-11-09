#Retirando os NA
dataset <- ConsumoNAN

#Essa i a selecao dos campos que desejamos trabalhar 
dataset <- subset(dataset, select = c(1:3,6))

#Jungao de data e hora
dataset$DataHora <- paste(dataset$Date, dataset$Time)

#Formatando a data
dataset$DataHora <- as.POSIXct(dataset$DataHora, format="%d/%m/%Y %H:%M")

#Definindo a energia ativa como numero
dataset$Global_active_power <- as.numeric(dataset$Global_active_power) 

#testando se a variavel modificou 
as.numeric(dataset$Global_active_power) 

#Agrupando
dset1 <- aggregate(dataset$Global_active_power , by=list(format(dataset$DataHora, "%Y-%m-%d %H:00")), mean)

#=====================================================================
# Dataset 1: dataset containing the mean of global active power
#            X: Date (per hour and day difference)
#            Y: Mean of global active power
#=====================================================================

#Renomeando as colunas
names(dset1) <- c("Datas","SumEnergiaAtiva")

rescut <- dset1[8:34142,] #size = 34135

datedaytodiffnumber <- function(date1, hour, date_ref = as.Date("2006-12-17"))
{
  return(as.numeric(date1 - date_ref))
}

vecsize = nrow(rescut)

plot_res = data.frame(X = c(1:vecsize), Y = c(1:vecsize ))
for (i in 1:vecsize ) {
  st = strsplit(rescut$Datas[i], ' ')[[1]]
  st2 = strsplit(st[2], ':')[[1]]
  
  plot_res$X[i] = datedaytodiffnumber(as.Date(st[1]), as.numeric(st2[1]))
  plot_res$Y[i] = rescut$SumEnergiaAtiva[i]
}

#Agrupando
plot_res_day <- aggregate(plot_res$Y , by=list(plot_res$X), mean)
dataset_1_meanbyday <- plot_res_day

rm(plot_res_day)
rm(plot_res)
rm(rescut)
rm(dset1)
rm(dataset)

rm(datedaytodiffnumber)

rm(i)
rm(st)
rm(st2)
rm(vecsize)

names(dataset_1_meanbyday) <- c("X","Y")

write.csv(dataset_1_meanbyday, file = "energyconsumption_dataset_v1.csv")

plot(dataset_1_meanbyday, pch=16)
model_lm_R <- lm(Y ~ (X), dataset_1_meanbyday)
abline(model_lm_R, col = "red")