# Read in data from the supplied dataset
#
# The Dataset is available at the following URL: 
#    https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#  
# After downloading the zip file, extract the houshold_power_consumption.txt file into the folder
# with this code file.
#
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
png("plot4.png",width=480,height=480)

# Plot the data
par(mfrow = c(2, 2))
with(hpcSubset,{
    plot(DateTime, 
         as.numeric( as.character( Global_active_power))/500,
         type="o",
         pch=NA,
         ylab="Global Active Power (Kilowatts)",
         xlab="")
    
    plot(DateTime, 
         as.numeric( as.character(Voltage)),
         type="o",
         pch=NA,
         ylab="Voltage")

    plot(DateTime,
        as.numeric(as.character(Sub_metering_1)),
        type="l",
        ylab="Energy Sub-Metering",
        xlab="",
        yaxt="n",
        col="black")
    axis(2,at=c(0,10,20,30))
    lines(DateTime,
        as.numeric(as.character(Sub_metering_2)),
        type="l",
        col="red",
        lwd=1)
    lines(DateTime,
        as.numeric(as.character(Sub_metering_3)),
        type="l",
        col="blue",
        lwd=1)
    legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)
    
    plot(DateTime, 
         as.numeric( as.character(Global_reactive_power)),
         type="o",
         pch=NA,
         ylab="Global_reactive_power")
})


# Close the graphics device
dev.off()