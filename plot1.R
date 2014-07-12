# Read in data from the supplied dataset
hpc <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

# Convert the Date and Time columns to a new column, named DateTime
hpc$DateTime <- strptime(paste(hpc$Date,hpc$Time),"%d/%m/%Y %H:%M:%S")

# subset the date, finding the date from two days in February of 2007
hpcSubset <- hpc[ !is.na(hpc$DateTime) & as.Date(hpc$DateTime) >= "2007-02-01" & as.Date(hpc$DateTime) <= "2007-02-02" ,]

# Replace "?" with NA value
hpcSubset[hpcSubset$Global_active_power=="?"] <- NA
hpcSubset[hpcSubset$Global_reactive_power=="?"] <- NA
hpcSubset[hpcSubset$Voltage=="?"] <- NA
hpcSubset[hpcSubset$Global_intensity=="?"] <- NA
hpcSubset[hpcSubset$Sub_metering_1=="?"] <- NA
hpcSubset[hpcSubset$Sub_metering_2=="?"] <- NA
hpcSubset[hpcSubset$Sub_metering_3=="?"] <- NA

# Open PNG graphics device
png("plot1.png",width=480,height=480)

# column values are factors, so this should be accounted for when graphing
# Division by 500 scales of values into KW.
hist(as.numeric(hpcSubset$Global_active_power)/500,
     col="red", 
     xlab="Global Active Power (Kilowatts)",
     main="Global Active Power")

# close graphics device
dev.off()
