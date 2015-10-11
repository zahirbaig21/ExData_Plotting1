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

##Plot 3

png("plot3.png")
plot(reqDates$DateTime, reqDates$Sub_metering_1, type = "l", 
     main = "Intraday Energy Sub-Metering", xlab = "Day", 
     ylab = "Energy Sub Metering", col = "red")
lines(reqDates$DateTime, reqDates$Sub_metering_2, col = "green")
lines(reqDates$DateTime, reqDates$Sub_metering_3, col = "blue")
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1, 1, 1), 
       col = c("red", "green", "blue"))
dev.off()

