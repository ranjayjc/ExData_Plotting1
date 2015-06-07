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

# Plot Global Reactive Power
png(filename="plot2.png", width=480, height=480, units="px")
plot(strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S"), data$Global_active_power,"l", main="", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()
