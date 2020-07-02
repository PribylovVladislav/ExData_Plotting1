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


# Make plot as png

png(filename = "plot2.png", width = 480, height = 480)
par(mar = c(2.5, 4, 2, 2))
plot(HPC$DateTime, HPC$Global_active_power, type = 'l', ylab = 'Global Active Power (kilowatts)',
                                           cex.lab = 0.75, cex.axis = 0.75)
dev.off()