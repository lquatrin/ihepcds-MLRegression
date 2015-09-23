rm(list=ls())
StringsAsFactors = FALSE

HousehouldPowerConsumption = read.table("C:/Users/lquatrin/Downloads/household_power_consumption/household_power_consumption.txt", header=T, sep=";", as.is = !StringsAsFactors)

DateActPowerHousehouldPowerConsumption = subset(HousehouldPowerConsumption, select = c(1,3))

NADateActPowerHousehouldPowerConsumption = DateActPowerHousehouldPowerConsumption[DateActPowerHousehouldPowerConsumption$Global_active_power != '?',]

FilteredHousehouldPowerConsumption = NADateActPowerHousehouldPowerConsumption
FilteredHousehouldPowerConsumption$Global_active_power = as.numeric(FilteredHousehouldPowerConsumption$Global_active_power)

#number of dataset's rows
#nrow(dataset)

ReadDataFunc <- function(){
  print('hello')
  print('hello2')
  print('hello3')
  print('hello4')
}