#Reading, naming and subsetting power consumption data
power <- read.table("household_power_consumption.txt", sep=";")
colnames(power) = as.character(unlist(power[1,]))
power = power[-1, ]
head(power)

subpower <- subset(power, power$Date=="1/2/2007" | power$Date =="2/2/2007")

#calling the basic plot function
hist(as.numeric(as.character(subpower$Global_active_power)), 
     col="red", 
     main="Global Active Power", 
     xlab="Global Active Power(kilowatts)")

# annotating graph
title(main="Global Active Power")

# Construct the plot and save it to a PNG file
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

