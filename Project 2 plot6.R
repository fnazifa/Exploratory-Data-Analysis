library(dplyr)

# Reading the Source Classification Code rds file and saving to a dataframe SCC
SCC <- readRDS("Source_Classification_Code.rds")

SCC1 <- SCC %>%
        filter(Data.Category %in% c("Onroad","Nonroad")) %>%
        select(SCC, Data.Category)

# Reading the summary SCC PM 2.5 rds file and saving to a dataframe NEI
NEI <- readRDS("summarySCC_PM25.rds")

# Subsetting the dataframe to only baltimore region using fips = 24510
bcity_la_city <- subset(NEI, fips=="24510" | fips=="06037" )
joint <- merge(bcity_la_city, SCC1, by = "SCC")
head(joint)

# grouping by fips code and year and sum up the emissions and arrange the years
grouped <- joint %>%
        group_by(fips, year) %>%
        summarise(emissions=sum(Emissions)) %>%
        arrange(year)

#You can see the status
#write.csv(grouped, file = "source_v4.csv")

png("plot6.png")
barplot(grouped$emissions, 
        beside=TRUE, 
        col=grouped$fips,
        names.arg = grouped$year,
        xlab= "Year",
        ylab= PM[2.5] ~ " emissions (in Tons)", 
        ylim=c(0,10000), 
        main="Comparision" ~ PM[2.5] ~ " Emissions between Cities")
        

legend("topright", 
       legend = c("Los Angeles", "Baltimore"), 
       fill = c("cyan", "deeppink"))
dev.off()