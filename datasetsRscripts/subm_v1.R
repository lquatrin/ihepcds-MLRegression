#Require: ConsumoNAN
#dataset without the nan values: checked

#2.The dataset contains some missing values in the measurements (nearly 1,25% of the rows). 
#  All calendar timestamps are present in the dataset but for some timestamps, the measurement
#  values are missing: a missing value is represented by the absence of value between two 
#  consecutive semi-colon attribute separators. For instance, the dataset shows missing values 
#  on April 28, 2007.

dataset <- ConsumoNAN 
dataset <- subset(dataset, select = c(1:3,7:9))

dataset$DataHora <- paste(dataset$Date, dataset$Time)
dataset$DataHora <- as.POSIXct(dataset$DataHora, format="%d/%m/%Y %H:%M")

dataset$Global_active_power <- as.numeric(dataset$Global_active_power) 
dataset$Sub_metering_1      <- as.numeric(dataset$Sub_metering_1) 
dataset$Sub_metering_2      <- as.numeric(dataset$Sub_metering_2) 
dataset$Sub_metering_3      <- as.numeric(dataset$Sub_metering_3) 

#1.(global_active_power*1000/60 - sub_metering_1 - sub_metering_2 - sub_metering_3) 
#  represents the active energy consumed every minute (in watt hour) in the household
#  by electrical equipment not measured in sub-meterings 1, 2 and 3. 
for (i in 1:nrow(dataset) ) {
  dataset$Global_active_power = dataset$Global_active_power*(1000/60) - dataset$Sub_metering_1 - dataset$Sub_metering_2 - dataset$Sub_metering_3 
}

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

datedaytodiffnumber <- function(date1, hour, date_ref = as.Date("2006-12-17"))
{
  return(as.numeric(date1 - date_ref))
}

vecsize = nrow(dset_gp)

dataset_sub_vs1_global = data.frame(X = c(1:vecsize), Y = c(1:vecsize ))
dataset_sub_vs1_submt1 = data.frame(X = c(1:vecsize), Y = c(1:vecsize ))
dataset_sub_vs1_submt2 = data.frame(X = c(1:vecsize), Y = c(1:vecsize ))
dataset_sub_vs1_submt3 = data.frame(X = c(1:vecsize), Y = c(1:vecsize ))

for (i in 1:vecsize ) {
  st = strsplit(dset_gp$Datas[i], ' ')[[1]]
  st2 = strsplit(st[2], ':')[[1]]
  
  diffnumber = datedaytodiffnumber(as.Date(st[1]), as.numeric(st2[1]))
  dataset_sub_vs1_global$X[i] = diffnumber
  dataset_sub_vs1_submt1$X[i] = diffnumber
  dataset_sub_vs1_submt2$X[i] = diffnumber
  dataset_sub_vs1_submt3$X[i] = diffnumber
  
  dataset_sub_vs1_global$Y[i] = dset_gp$X0[i]
  dataset_sub_vs1_submt1$Y[i] = dset_s1$X1[i]
  dataset_sub_vs1_submt2$Y[i] = dset_s2$X2[i]
  dataset_sub_vs1_submt3$Y[i] = dset_s3$X3[i]
}

dataset_sub_vs1_global <- aggregate(dataset_sub_vs1_global$Y , by=list(dataset_sub_vs1_global$X), mean)
dataset_sub_vs1_submt1 <- aggregate(dataset_sub_vs1_submt1$Y , by=list(dataset_sub_vs1_submt1$X), mean)
dataset_sub_vs1_submt2 <- aggregate(dataset_sub_vs1_submt2$Y , by=list(dataset_sub_vs1_submt2$X), mean)
dataset_sub_vs1_submt3 <- aggregate(dataset_sub_vs1_submt3$Y , by=list(dataset_sub_vs1_submt3$X), mean)

dataset_sub_vs1_meanbyday <- dataset_sub_vs1_global

dataset_sub_vs1_meanbyday$Y1 <- dataset_sub_vs1_submt1$x
dataset_sub_vs1_meanbyday$Y2 <- dataset_sub_vs1_submt2$x
dataset_sub_vs1_meanbyday$Y3 <- dataset_sub_vs1_submt3$x

names(dataset_sub_vs1_meanbyday) <- c("X","Y", "Y1", "Y2", "Y3")

rm(dataset_sub_vs1_global)
rm(dataset_sub_vs1_submt1)
rm(dataset_sub_vs1_submt2)
rm(dataset_sub_vs1_submt3)

rm(dataset)

rm(dset_gp)
rm(dset_s1)
rm(dset_s2)
rm(dset_s3)

rm(datedaytodiffnumber)
rm(vecsize)

rm(i)
rm(st)
rm(st2)
rm(diffnumber)