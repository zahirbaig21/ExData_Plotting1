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

##Plot 2

png("plot2.png")
plot(reqDates$DateTime, reqDates$Global_active_power, type = "l", 
     main = "Intraday Global Active Power (kW)", xlab = "Day", 
     ylab = "Global Active Power (kilowatts)")
dev.off()

