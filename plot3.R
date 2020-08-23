#Load electric data
electricZip <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(electricZip, temp)
electric <- read.csv(unz(temp, "household_power_consumption.txt"), sep = ";")
unlink(temp)
electric[,1] <- as.Date(electric[,1], "%d/%m/%Y")

#Refine to use only required dates
electricReduced <- electric[electric$Date <= "2007-02-02" & electric$Date >= "2007-02-01",]

#Remove electric large dataframe
rm(electric)

#Change times to time
electricReduced$Time <- strptime(electricReduced$Time, format = "%H:%M:%S")
electricReduced$Time <- strftime(electricReduced$Time, format = "%H:%M:%S")

#plot3
electricReduced$datetime <- as.POSIXct(paste(electricReduced$Date, electricReduced$Time), format="%Y-%m-%d %H:%M:%S")
electricReduced$Sub_metering_1 <- as.numeric(as.character(electricReduced$Sub_metering_1))
electricReduced$Sub_metering_2 <- as.numeric(as.character(electricReduced$Sub_metering_2))
electricReduced$Sub_metering_3 <- as.numeric(as.character(electricReduced$Sub_metering_3))
par(mfrow=c(1,1))
with(electricReduced, plot(electricReduced$datetime, electricReduced$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", cex.lab=0.9, cex.axis=0.9))
lines(electricReduced$datetime, electricReduced$Sub_metering_2, col="red")
lines(electricReduced$datetime, electricReduced$Sub_metering_3, col="blue")
legend("topright", lty = 1, col=c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), cex=0.9, pt.cex = 0.9, xjust = 1)
dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px")
dev.off()