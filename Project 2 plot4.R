library(dplyr)

# Reading the Source Classification Code rds file and saving to a dataframe SCC
SCC <- readRDS("Source_Classification_Code.rds")

# Write to source.csv and then open in spreadsheet - do conditional formating on text that contains "coal"
#write.csv(SCC, file = "source.csv")

SCC1 <- SCC %>%
        select(SCC, Data.Category, Short.Name, EI.Sector)

#names(SCC1)[2] <- "type"        
coal_all <- SCC1[with(SCC1, grepl("Coal", paste(Short.Name, EI.Sector))),]

# Write to source_v2.csv and then open in spreadsheet - do conditional formating on text that contains "coal" to be confirmed
#write.csv(coal_all, file = "source_v2.csv")

# Reading the summary SCC PM 2.5 rds file and saving to a dataframe NEI
NEI <- readRDS("summarySCC_PM25.rds")
NEI1 <- NEI %>%
        select(SCC, year, Emissions)

jointdataset <- merge(NEI1, coal_all, by = "SCC")
head(jointdataset)

# Write to source_v3.csv and then open in spreadsheet - to check whether it got inner joined on SCC or not
#write.csv(jointdataset, file = "source_v3.csv")
#str(jointdataset)

coal <- tapply(jointdataset$Emissions/1000, jointdataset$year, FUN=sum)
png("plot4.png")
barplot(coal, 
        xlab="Year", 
        ylab= PM[2.5] ~ " emissions (in Thousand Tons)",
        main="Total" ~ PM[2.5] ~ " Emissions From Coal Sources",
        ylim=c(0,800))
dev.off()