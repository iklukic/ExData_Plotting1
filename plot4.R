#set the working directory
setwd("D:/R/exploratory_1/")

#load the sqldf library, needed to parse in the correct time points
library(sqldf)

#setting the path to the entire set
path.household <- "D:/R/exploratory_1/household_power_consumption.txt"

#use sqldf package to load the observations made on 01/02/2007 and 02/02/2007 and store it as two.days dataframe
two.days <- read.csv.sql(path.household, sep=";",sql = 'select * from file where Date = "1/2/2007" or Date = "2/2/2007" ')

#concatenate Date and Time columns and convert them to time format (new Date column)
two.days$Date <- strptime(paste(two.days$Date,two.days$Time), "%d/%m/%Y %H:%M:%S")

#convert the format of the Date from POSIXlt to POSIXct
#two.days$Date <- as.POSIXct(two.days$Date)

#set the png file properties
png("plot4.png", width = 480, height = 480)

#prepare the layout
par(mfcol=c(2,2))

#subplot 1,1
#create the plot of global active power over time
#set the plot without data points
plot(two.days$Date, two.days$Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)")

#add the line
lines(two.days$Date, two.days$Global_active_power, type="l")

#subplot 2,1
#create the plot of energy sub metering over time
#set the plot without data points
plot(two.days$Date, two.days$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")

#add the line for sub metering 1 (black)
lines(two.days$Date, two.days$Sub_metering_1, type="l")

#add the line for sub metering 2 (red)
lines(two.days$Date, two.days$Sub_metering_2, type="l", col="red")

#add the line for sub metering 3 (blue)
lines(two.days$Date, two.days$Sub_metering_3, type="l", col="blue")

#plot legend
legend("topright", lwd=1, col=c("black", "red", "blue"), bty="n", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#subplot 1,2
#create the plot of voltage over time
#set the plot without data points
plot(two.days$Date, two.days$Voltage, type="n", xlab="datetime", ylab="Voltage")

#add the voltage line
lines(two.days$Date, two.days$Voltage, type="l")

#subplot 2,2
#create the plot of global reactive power
#set the plot without data points
plot(two.days$Date, two.days$Global_reactive_power, type="n", xlab="datetime", ylab="Global_reactive_power")

#add the global reactive power line
lines(two.days$Date, two.days$Global_reactive_power, type="l")


#close the graphics device
dev.off()
