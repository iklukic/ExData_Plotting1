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
png("plot1.png", width = 480, height = 480)

#create the histogram of global active power
hist(two.days$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")

#close the graphics device
dev.off()
