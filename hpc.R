hpc <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

hpc$Date <- as.Date(hpc$Date,"%d/%m/%Y")
# hpc$Time <- strptime(hpc$Time,"")
