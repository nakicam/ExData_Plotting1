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

# Convert Global_active_power to numeric
globalActivePower <- as.numeric(subset_data$Global_active_power)

#Convert datetime as POSIXct to get the weekdays
submetering1 <- as.numeric(sub_data$Sub_metering_1)
submetering2 <- as.numeric(sub_data$Sub_metering_2)
submetering3 <- as.numeric(sub_data$Sub_metering_3)
datetime <- paste(as.Date(sub_data$Date), sub_data$Time)
sub_data$Datetime <- as.POSIXct(datetime)

## Plot 3
plot(submetering1~Datetime, data = sub_data, type="l", ylab="Energy sub metering", xlab="")
lines(submetering2~Datetime, data = sub_data, type="l", col = "red")
lines(submetering3~Datetime, data = sub_data, type="l", col = "blue")
legend("topright", col = c("black","red","blue"), lty = 1, lwd = 2, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()