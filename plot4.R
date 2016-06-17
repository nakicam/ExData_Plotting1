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


# Convert to numeric
globalActivePower <- as.numeric(sub_data$Global_active_power)
voltage <- as.numeric(sub_data$Voltage)
globalReactivePwr <- as.numeric(sub_data$Global_reactive_power)
submetering1 <- as.numeric(sub_data$Sub_metering_1)
submetering2 <- as.numeric(sub_data$Sub_metering_2)
submetering3 <- as.numeric(sub_data$Sub_metering_3)

#Convert datetime as POSIXct to get the weekdays
datetime <- paste(as.Date(sub_data$Date), sub_data$Time)
sub_data$Datetime <- as.POSIXct(datetime)

# Creating 4 plot frames
par(mfrow = c(2, 2), mar=c(4,4,2,1), oma=c(0,0,2,0))

## Plot 1
with(sub_data, plot(globalActivePower~Datetime, type="l", ylab="Global Active Power", xlab=""))

## Plot 2
with(sub_data, plot(voltage~Datetime, type="l", ylab="Voltage", xlab="datetime"))

## Plot 3
with(sub_data, plot(submetering1~Datetime, type="l", ylab="Energy sub metering", xlab=""))
with(sub_data,lines(submetering2~Datetime, type="l", col = "red"))
with(sub_data,lines(submetering3~Datetime, type="l", col = "blue"))
legend("topright", col = c("black","red","blue"), lty = 1, lwd = 2, bty="n", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## Plot 4
with(sub_data, plot(globalReactivePwr~Datetime, type="l", ylab="Global_reactive_power", xlab="datetime"))
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()