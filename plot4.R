Sys.setlocale(locale = "english")

# Download and save file

if(!file.exists('./data/HPS.zip')) {
  if(!dir.exists('./data')) {dir.create('./data')}
  fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(fileURL, './data/HPS.zip')
  dir.create('./data/HPS')
  unzip('./data/HPS.zip', exdir = './data/HPS')
}

# Data processing

HPC <- read.table('./data/HPS/household_power_consumption.txt', sep =";", header = TRUE)
HPC$Date <- as.character(HPC$Date)
HPC <- subset(HPC, (HPC$Date == '1/2/2007' | Date == '2/2/2007'))
HPC$Global_active_power <- as.numeric(as.character(HPC$Global_active_power))
HPC$Global_reactive_power <- as.numeric(as.character(HPC$Global_reactive_power))
HPC$DateTime <- strptime(paste(HPC$Date, HPC$Time, sep = ' '), format = '%d/%m/%Y %H:%M:%S')
HPC$Voltage <- as.numeric(as.character(HPC$Voltage))
HPC$Sub_metering_1 <- as.numeric(as.character(HPC$Sub_metering_1))
HPC$Sub_metering_2 <- as.numeric(as.character(HPC$Sub_metering_2))
HPC$Sub_metering_3 <- as.numeric(as.character(HPC$Sub_metering_3))

# Make plot as png

png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2), mar = c(4, 4, 2, 2), oma = c(2, 2, 2, 2))
plot(HPC$DateTime, HPC$Global_active_power, type = 'l', xlab = '', ylab = 'Global Active Power')

plot(HPC$DateTime, HPC$Voltage, type = 'l', xlab = 'datetime',  ylab = 'Voltage', ylim = c(234, 246))

plot(HPC$DateTime, HPC$Sub_metering_1, type = 'l', xlab = '', ylab = 'Energy sub metering')
lines(HPC$DateTime, HPC$Sub_metering_2, type = 'l', col = 'red')
lines(HPC$DateTime, HPC$Sub_metering_3, type = 'l', col = 'blue')
legend('topright', inset = .02, legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       col = c('black', 'red', 'blue'), lty = 1, lwd = 1, box.lty = 0, cex = 0.9)

plot(HPC$DateTime, HPC$Global_reactive_power, type = 'l', xlab = 'datetime', ylab = 'Global_reactive_power', ylim = c(0.0, 0.5))
dev.off()