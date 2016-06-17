# Load library
library(httr)
library(dplyr)

# Download file from http
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "data.zip")

# unzip file
unzip("data.zip")

# Read data from txt file
daten <- read.table("household_power_consumption.txt", header = TRUE, sep = ";"
                       , check.names=F, stringsAsFactors=F, comment.char="", quote='\"', dec = ".")



#Filter ? -> new dataframe 
daten_clean <- filter(daten, daten$Global_active_power != "?")

#Convert date format
daten_clean$Date <- as.Date(daten_clean$Date, format="%d/%m/%Y")

#Filter only the required data of dates 2007-02-01 and 2007-02-02
sub_data <- filter(daten_clean, daten_clean$Date >= "2007-02-01" & Date <= "2007-02-02")

#Remove datasets
rm(daten)
rm(daten_clean)

#Plot 1
#Cast Global_active_power as number
globalActivePower <- as.numeric(sub_data$Global_active_power)
hist(globalActivePower, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red")
dev.copy(png, file = "plot1.png", height=480, width=480)
dev.off()