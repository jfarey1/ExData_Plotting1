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

#plot2
electricReduced$datetime <- as.POSIXct(paste(electricReduced$Date, electricReduced$Time), format="%Y-%m-%d %H:%M:%S")
par(mfrow=c(1,1))
with(electricReduced, plot(electricReduced$datetime, electricReduced$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px")
dev.off()