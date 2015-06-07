# Initialize Input Parameters
dataFile <- "household_power_consumption.txt"
winDateOpen <- "01/02/2007"
winDateClose <- "02/02/2007"

# Calculate the number of data points (one per minute) that need to be read.
winOpen <- strptime(paste(winDateOpen, "00:00:00"), format="%d/%m/%Y %H:%M:%S")
winClose <- strptime(paste(winDateClose, "23:59:00"), format="%d/%m/%Y %H:%M:%S")
durationMinutes <- difftime(winClose, winOpen, units="min") + 1

# Calculate the number lines to skip
dataStart = read.table(dataFile, header=TRUE, sep = ";", nrows=1)
dataStartTime= strptime(paste(dataStart$Date, dataStart$Time), "%d/%m/%Y %H:%M:%S")
minutesToSkip = difftime(winOpen, dataStartTime, units = "min")

# Read the lines in the dataset that need to be analyzed
header = read.table(dataFile, header=FALSE, sep = ";", nrows=1, stringsAsFactors=FALSE)
energyData = read.table(dataFile, header=FALSE, sep = ";", skip=minutesToSkip+1, nrows=durationMinutes)

# 4 Plots in same figure
png(filename="plot4.png", width=480, height=480, units="px")

par(mfrow=c(2, 2))
plot(strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S"), data$Global_active_power,"l", main="", ylab="Global Active Power", xlab="")

plot(strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S"), data$Voltage,"l", main="", ylab="Voltage", xlab="datetime")

plot(strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S"), data$Sub_metering_1, "n", main="", ylab="Energy sub metering", xlab="")
points(strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S"), data$Sub_metering_1, "l", col="black")
points(strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S"), data$Sub_metering_2, "l", col="red")
points(strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S"), data$Sub_metering_3, "l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1, 1, 1), col=c("black", "red", "blue"), bty="n")

plot(strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S"), data$Global_reactive_power,"l", main="", ylab="Global_reactive_power", xlab="datetime")

dev.off()
