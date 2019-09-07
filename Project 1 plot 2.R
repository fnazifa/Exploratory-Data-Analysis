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

plot(subpower$date_time, subpower$Global_active_power , type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.copy(png,"plot3.png", width=480, height=480)
dev.off()