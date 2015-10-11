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

##Create histogram of Global Active Power (plot1)

png("plot1.png")
hist(reqDates$Global_active_power, col = "blue", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

dev.off()

