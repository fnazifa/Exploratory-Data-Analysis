# Reading the summary SCC PM 2.5 rds file and saving to a dataframe NEI
NEI <- readRDS("summarySCC_PM25.rds")

# Subsetting the dataframe to only baltimore region using fips = 24510
baltimore <- subset(NEI, fips=="24510")

# Computing the summation of emissions per year for the baltimore region
baltimore_Emissions <- tapply(baltimore$Emissions, baltimore$year, FUN=sum)

# Plotting a bar chart
png("plot2.png")
barplot(baltimore_Emissions, 
        xlab= "Year",
        ylab= PM[2.5] ~ " emissions (in Tons)", 
        ylim=c(0,4000), 
        main="Total" ~ PM[2.5] ~ " Emissions From Baltimore City")
dev.off()