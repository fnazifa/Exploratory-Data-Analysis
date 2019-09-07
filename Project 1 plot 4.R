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

par(mfrow=c(2,2),mar=c(4,4,2,1), oma=c(0,0,2,0))
plot(subpower$date_time, subpower$Global_active_power, type="l", 
     ylab="Global Active Power", xlab="", col="black")
plot(subpower$date_time, subpower$Voltage, type="l", ylab="Voltage", xlab="datetime", col="black")
plot(subpower$date_time, subpower$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", col="black")
lines(subpower$date_time, subpower$Sub_metering_2, type="l", col="red")
lines(subpower$date_time, subpower$Sub_metering_3, type="l", col="blue")
#op <- par(cex = 0.4)
legend("topright", col=c("black", "red", "blue"), cex=0.25, lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), y.intersp = 0.5, pt.cex = 1, ncol=1)
plot(subpower$date_time, subpower$Global_reactive_power, type="l", col="black", 
     ylab="Global Reactive Power", xlab="datetime", width=480, height=480)

dev.copy(png,"plot4.png", width=480, height=480)
dev.off()

