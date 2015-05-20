#install.packages("ggplot2")
library(ggplot2)
library(plyr)

#global vars
DATA_URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
ZIP_FILE <- './exdata-data-NEI_data.zip'

#check file existence, if necessary it will download it
if(!file.exists(ZIP_FILE)){
  download.file(DATA_URL, ZIP_FILE, method = "curl")
  unzip(ZIP_FILE)
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC_whereiscoal <- grep("coal",ds_SCC$EI.Sector,value=T,ignore.case=T)
SCC_onlycoal <- subset(SCC, EI.Sector %in% SCC_whereiscoal, select=SCC)

NEI_onlycoal <- subset(NEI, SCC %in% SCC_onlycoal$SCC)

PM25_onlycoal_byear <- ddply(NEI_onlycoal, .(year), function(agg) sum(agg$Emissions) )
colnames(PM25_onlycoal_byear)[2] <- "Emissions"

png("plot4.png")
qplot(year, Emissions, data=PM25_onlycoal_byear, geom="line") +
  geom_line(aes(size="total", shape = NA)) +
  ggtitle(expression("PM2.5 Emissions of Coal Combustion by year")) +
  xlab("Year") +
  ylab("PM2.5 Emissions (tons)")

dev.off()