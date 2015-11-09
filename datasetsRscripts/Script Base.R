#Retirando os NA
ConsumoNAN <- na.omit(ConsumoEnergia)  

#Essa é a selecao dos campos que desejamos trabalhar 
ConsumoT <- subset(ConsumoNAN, select = c(1:3,6))

#Junçao de data e hora
ConsumoT$DataHora <- paste(ConsumoT$Date, ConsumoT$Time)

#Formatando a data
ConsumoT$DataHora <- as.POSIXct(ConsumoT$DataHora, format="%d/%m/%Y %H:%M")

#Definindo a energia ativa como numero
ConsumoT$Global_active_power <- as.numeric(ConsumoT$Global_active_power) 

#testando se a variavel modificou 
as.numeric(ConsumoT$Global_active_power) 

#Agrupando
resultado <- aggregate(ConsumoT$Global_active_power , by=list(format(ConsumoT$DataHora, "%Y-%m-%d %H:00")), sum)

#Renomeando as colunas
names(resultado) <- c("Datas","SumEnergiaAtiva")

 