library(ggplot2)

# Reading the summary SCC PM 2.5 rds file and saving to a dataframe NEI
NEI <- readRDS("summarySCC_PM25.rds")

# Subsetting the dataframe to only baltimore region using fips = 24510
baltimore <- subset(NEI, NEI$fips == "24510")

# Aggregating the summation of emission with year and type
baltimoreType <- aggregate(Emissions ~ year + type, baltimore, sum)

# Plotting a line graph of all types with different colors
png("plot3.png")
ggplot(baltimoreType, aes(year, Emissions, col = type)) +
        geom_line(size=1) + 
        ggtitle(("Total" ~ PM[2.5] ~ " Emissions From Baltimore City by Category")) +
        ylab(expression(PM[2.5] ~ " emissions (in Tons)")) + xlab("Year") 
dev.off()