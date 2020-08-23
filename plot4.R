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

#plot4
par(mfrow = c(2,2))
with(electricReduced, {
  plot(electricReduced$datetime, electricReduced$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power", cex.lab=0.7, cex.axis=0.7)
  plot(electricReduced$datetime, electricReduced$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", cex.lab=0.7, cex.axis=0.7)
  plot(electricReduced$datetime, electricReduced$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", cex.lab=0.7, cex.axis=0.7)
    lines(electricReduced$datetime, electricReduced$Sub_metering_2, col="red")
    lines(electricReduced$datetime, electricReduced$Sub_metering_3, col="blue")
    legend("topright", bty = "n", lty = 1, col=c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), cex=0.6, pt.cex = 0.6, xjust = 0)
  plot(electricReduced$datetime, electricReduced$Global_reactive_power , type = "l", xlab = "datetime", ylab = "Global_reactive_power", cex.lab=0.7, cex.axis=0.7)
})
dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")
dev.off()