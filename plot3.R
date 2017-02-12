setwd("/Users/Edo1/Documents/Education/Coursera/Data Science_JH/4_Exploratory Data Analysis")

############# GET THE DATA ########################

# If the "data" directory doesn't exist, create one
if(!file.exists("data")){
  dir.create("data")
}

# Download the data set as "zippedData.zip" and store it in the "data" directory
if(!file.exists("./data/zippedData.zip")){
  
  URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  destfile <- "./data/zippedData.zip"
  download.file(URL,destfile)
  
  # Unzip the file
  unzip(zipfile = destfile, exdir ="./data")
}

############# READ THE DATA ########################

dataFile <- "./data/household_power_consumption.txt"
data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".", na.strings = "?")
subsetData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

## Convert the Date and Time variables to Date/Time classes in R
dateTime <- strptime(paste(subsetData$Date, subsetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

# Change column values to numeric for Plots 1 - 4
globalActivePower <- as.numeric(subsetData$Global_active_power)
globalReactivePower <- as.numeric(subsetData$Global_reactive_power)
globalIntensity <- as.numeric(subsetData$Global_intensity)
voltage <- as.numeric(subsetData$Voltage)
subMetering1 <- as.numeric(subsetData$Sub_metering_1)
subMetering2 <- as.numeric(subsetData$Sub_metering_2)
subMetering3 <- as.numeric(subsetData$Sub_metering_3)

############ PLOT 3 ################################

png("plot3.png", width=480, height=480)
plot(dateTime, subMetering1, type="l",  xlab = "", ylab="Energy sub metering", col ="black")
lines(dateTime,subMetering2,type='l',col='red')
lines(dateTime,subMetering3,type='l',col='blue')
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=2, lty=1, col=c("black", "red", "blue"))

dev.off()