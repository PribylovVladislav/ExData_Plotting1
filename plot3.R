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
HPC$DateTime <- strptime(paste(HPC$Date, HPC$Time, sep = ' '), format = '%d/%m/%Y %H:%M:%S')
HPC$Sub_metering_1 <- as.numeric(as.character(HPC$Sub_metering_1))
HPC$Sub_metering_2 <- as.numeric(as.character(HPC$Sub_metering_2))
HPC$Sub_metering_3 <- as.numeric(as.character(HPC$Sub_metering_3))

# Make plot as png

png(filename = "plot3.png", width = 480, height = 480)
par(mar = c(2.5, 4, 2, 2))
plot(HPC$DateTime, HPC$Sub_metering_1, type = 'l', ylab = 'Energy sub metering')
lines(HPC$DateTime, HPC$Sub_metering_2, type = 'l', col = 'red')
lines(HPC$DateTime, HPC$Sub_metering_3, type = 'l', col = 'blue')
legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       col = c('black', 'red', 'blue'), lty = 1, lwd = 1)
dev.off()