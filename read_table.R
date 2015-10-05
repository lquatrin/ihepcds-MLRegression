#setwd("E:/GitHub/ihepcds-MLRegression")
#setwd("C:/Users/lquatrin/GitHub/ihepcds-MLRegression")
#source("read_table.r")

rm(list=ls())
StringsAsFactors = FALSE
print("Pre Processing Started...")

HousehouldPowerConsumption = read.table("household_power_consumption.txt", header=T, sep=";", as.is = !StringsAsFactors)
print("HousehouldPowerConsumption done...")

DateActPowerHousehouldPowerConsumption = subset(HousehouldPowerConsumption, select = c(1,3))
print("DateActPowerHousehouldPowerConsumption done...")

NADateActPowerHousehouldPowerConsumption = DateActPowerHousehouldPowerConsumption[DateActPowerHousehouldPowerConsumption$Global_active_power != '?',]
print("NADateActPowerHousehouldPowerConsumption done...")

FilteredHousehouldPowerConsumption = NADateActPowerHousehouldPowerConsumption
FilteredHousehouldPowerConsumption$Global_active_power = as.numeric(FilteredHousehouldPowerConsumption$Global_active_power)
print("FilteredHousehouldPowerConsumption done...")

NumericHousehouldPowerConsumption = FilteredHousehouldPowerConsumption
NumericHousehouldPowerConsumption$Date = as.numeric(as.POSIXct(NumericHousehouldPowerConsumption$Date, format="%d/%m/%y"))
#NumericHousehouldPowerConsumption$Date <- as.Date(NumericHousehouldPowerConsumption$Date, "%d/%m/%Y")

print("NumericHousehouldPowerConsumption done...")

print("Pre Processing finished")

#plot(NumericHousehouldPowerConsumption$Date, NumericHousehouldPowerConsumption$Global_active_power)