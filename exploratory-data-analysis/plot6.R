install.packages("ggplot2")
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

NEI_balt_la_mv <- subset(NEI, (fips == "24510" | fips == "06037") & type=="ON-ROAD")
NEI_balt_la_mv <- transform(MV, region = ifelse(fips == "24510", "Baltimore City", "Los Angeles County"))

balt_la_mv_pm25_year <- ddply(NEI_balt_la_mv, .(year, region), function(data) sum(data$Emissions))
colnames(balt_la_mv_pm25_year)[3] <- "Emissions"

png("plot6.png")
qplot(year, Emissions, data=balt_la_mv_pm25_year, color=region) +
  ggtitle("PM2.5 Vehicle Emissions in Baltimore vs. LA") +
  xlab("Year") +
  ylab("Total PM2.5 Emissions (tons)") +
  geom_smooth(alpha=.2, size=1, method="loess")
dev.off()
