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

NEI_baltmore_mv <- subset(NEI, type=="ON-ROAD" & fips == "24510")
baltimore_mv_pm25_year <- ddply(NEI_baltmore_mv, .(year), function(data) sum(data$Emissions) )
colnames(baltimore_mv_pm25_year)[2] <- "Emissions"

png("plot5.png")
qplot(year, Emissions, data=baltimore_mv_pm25_year, geom="line") +
  xlab("Year") +
  ylab("Total PM2.5 Emissions (tons)") +
  ggtitle("BaltimoreCity PM2.5 Motor Vehicle Emissions by Year")
dev.off()