require(ggplot2)
require(reshape2)
library(magrittr)
library(dplyr)

power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                    na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

power$Date <- as.Date(power$Date, "%d/%m/%Y")
power <- power[complete.cases(power),]
power$date_time <- (paste(power$Date, power$Time))


subpower <- power %>% filter(Date >= "2007-2-1" & Date <="2007-2-2")
subpower <- subpower %>% select(-Date, -Time,date_time, everything())
subpower$date_time <- as.POSIXct(subpower$date_time)
head(subpower)

plot(subpower$date_time, subpower$Sub_metering_1 , type="l", ylab="Global Active Power (kilowatts)", xlab="", col="black")
lines(subpower$date_time, subpower$Sub_metering_2 , type="l", ylab="Global Active Power (kilowatts)", xlab="", col="red")
lines(subpower$date_time, subpower$Sub_metering_3 , type="l", ylab="Global Active Power (kilowatts)", xlab="", col="blue")

legend("topright", col=c("black", "red", "blue"), cex=0.5, lty=1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       y.intersp=0.5)

dev.copy(png,"plot3.png", width=480, height=480)
dev.off()

