dataset <- ConsumoNAN

dataset <- subset(dataset, select = c(1:3,7:9))

dataset$DataHora <- paste(dataset$Date, dataset$Time)
dataset$DataHora <- as.POSIXct(dataset$DataHora, format="%d/%m/%Y %H:%M")


dataset$Global_active_power <- as.numeric(dataset$Global_active_power) 
dataset$Sub_metering_1      <- as.numeric(dataset$Sub_metering_1) 
dataset$Sub_metering_2      <- as.numeric(dataset$Sub_metering_2) 
dataset$Sub_metering_3      <- as.numeric(dataset$Sub_metering_3) 

dset_gp <- aggregate(dataset$Global_active_power , by=list(format(dataset$DataHora, "%Y-%m-%d %H:00")), mean)
dset_s1 <- aggregate(dataset$Sub_metering_1 , by=list(format(dataset$DataHora, "%Y-%m-%d %H:00")), mean)
dset_s2 <- aggregate(dataset$Sub_metering_2 , by=list(format(dataset$DataHora, "%Y-%m-%d %H:00")), mean)
dset_s3 <- aggregate(dataset$Sub_metering_3 , by=list(format(dataset$DataHora, "%Y-%m-%d %H:00")), mean)

names(dset_gp) <- c("Datas","X0")
names(dset_s1) <- c("Datas","X1")
names(dset_s2) <- c("Datas","X2")
names(dset_s3) <- c("Datas","X3")

dset_gp <- dset_gp[8:34142,] #size = 34135
dset_s1 <- dset_s1[8:34142,] #size = 34135
dset_s2 <- dset_s2[8:34142,] #size = 34135
dset_s3 <- dset_s3[8:34142,] #size = 34135

dataset_sub_vs1_meanbyday <- dset_gp
dataset_sub_vs1_meanbyday$X1 <- dset_s1$X1
dataset_sub_vs1_meanbyday$X2 <- dset_s2$X2
dataset_sub_vs1_meanbyday$X3 <- dset_s3$X3

dataset <- dataset_sub_vs1_meanbyday
names(dataset) <- c("DiaHora","Global", "Sub1", "Sub2", "Sub3")

dataset$Dia <- dataset$DiaHora
dataset$Hora <- dataset$DiaHora

vecsize = nrow(dataset)

datedaytodiffnumber <- function(date1, hour, date_ref = as.Date("2006-12-17"))
{
  return(as.numeric(date1 - date_ref))
}

for (i in 1:vecsize ) {
  st = strsplit(dataset$DiaHora[i], ' ')[[1]]
  st2 = strsplit(st[2], ':')[[1]]
  
  hour <- as.numeric(st2[1])
  
  diffnumber = datedaytodiffnumber(as.Date(st[1]), as.numeric(st2[1]))
  
  dataset$Dia[i] = diffnumber
  dataset$Hora[i] = hour
}

dataset$DiaHora = NULL