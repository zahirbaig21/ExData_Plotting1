##Load packages
library(dplyr)
library(data.table)

##Read all data
allData <- read.table("household_power_consumption.txt", sep = ";", 
                      na.strings = "?", header = TRUE)

##Convert to data table and keep only required dates
allDF <- tbl_df(allData)

reqDates <- filter(allDF, allDF$Date == "1/2/2007" | allDF$Date == "2/2/2007")

##Convert date column to date format
reqDates$Date <- as.Date(reqDates$Date, format = "%d/%m/%Y")

##Create new DateTime column and convert to date format
reqDates$DateTime <- paste(reqDates$Date, reqDates$Time)
reqDates$DateTime <- strptime(reqDates$DateTime, format = "%Y-%m-%d %H:%M:%S")



png("plot4.png")
#Set 4-panel plot
par(mfrow = c(2, 2))

#Plot 1
plot(reqDates$DateTime, reqDates$Global_active_power, type = "l", 
     xlab = "Day", ylab = "Global Active Power")

#Plot 2
plot(reqDates$DateTime, reqDates$Voltage, type = "l", 
     xlab = "Day", ylab = "Voltage")

#Plot 3
plot(reqDates$DateTime, reqDates$Sub_metering_1, type = "l", 
     xlab = "Day", ylab = "Energy Sub Metering", col = "red")
lines(reqDates$DateTime, reqDates$Sub_metering_2, col = "green")
lines(reqDates$DateTime, reqDates$Sub_metering_3, col = "blue")
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1, 1, 1), 
       col = c("red", "green", "blue"),
       cex = 0.7)

#Plot 4
plot(reqDates$DateTime, reqDates$Global_reactive_power, type = "l", 
     xlab = "Day", ylab = "Global Reactive Power", lwd = 0.5)

dev.off()

