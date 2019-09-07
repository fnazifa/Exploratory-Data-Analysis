# Reading the summary SCC PM 2.5 rds file and saving to a dataframe NEI
NEI <- readRDS("summarySCC_PM25.rds")

# Computing the summation of emissions per year and dividing with a million to keep the y-axis with small integer
emission <- tapply(NEI$Emissions/1000, NEI$year, FUN=sum)

# Plotting a bar chart
png("plot1.png")
barplot(emission, 
        xlab="Year", 
        ylab= PM[2.5] ~ " emissions (in Thousand Tons)", 
        ylim = c(0,8000), 
        main="Total" ~ PM[2.5] ~ " Emissions From All US Sources")
dev.off()