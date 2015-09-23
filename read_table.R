rm(list=ls())

stringsAsFactors = FALSE

dataset = read.table("C:/Users/lquatrin/Downloads/household_power_consumption/household_power_consumption.txt", header=T, sep=";", as.is = !stringsAsFactors)

#n??mero de linhas do dataset
nrow(dataset)