library(dplyr)

# Reading the Source Classification Code rds file and saving to a dataframe SCC
SCC <- readRDS("Source_Classification_Code.rds")
head(SCC)

# Write to source.csv and then open in spreadsheet - do conditional formating on text that contains "Onroad" and "Nonroad" in the Short.Name values, all the different forms of vehicles will show up
#write.csv(SCC, file = "source.csv")

SCC1 <- SCC %>%
        filter(Data.Category %in% c("Onroad","Nonroad")) %>%
        select(SCC, Data.Category)
head(SCC1)

# Write to source_v2.csv and then open in spreadsheet - do conditional formating on text that contains "coal" to be confirmed
#write.csv(coal_all, file = "source_v2.csv")

# Reading the summary SCC PM 2.5 rds file and saving to a dataframe NEI
NEI <- readRDS("summarySCC_PM25.rds")
NEI1 <- NEI %>%
        select(SCC, year, Emissions)

jointdataset <- merge(NEI1, SCC1, by = "SCC")
head(jointdataset)

# Write to source_v3.csv and then open in spreadsheet - to check whether it got inner joined on SCC or not
#write.csv(jointdataset, file = "source_v3.csv")
#str(jointdataset)

motor <- tapply(jointdataset$Emissions/1000, jointdataset$year, FUN=sum)
png("plot5.png")
barplot(motor, 
        xlab="Year", 
        ylab= PM[2.5] ~ " emissions (in Thousand Tons)",
        main="Total" ~ PM[2.5] ~ " Emissions From Motor Sources",
        ylim=c(0,500)
        )
dev.off()