install.packages("ggplot2")
library(ggplot2)

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

onlyBaltimore <- NEI[NEI$fips == 24510,]

aggregated <- aggregate(Emissions ~ year + type, onlyBaltimore, sum)

png('plot3.png')

plot <- ggplot(aggregated, aes(x = year, y = Emissions, color = type)) +
  geom_line() +
  xlab("Year") +
  ylab("PM2.5 emissions") +
  ggtitle("PM2.5 Emissions by source and year in Baltimore City")

print(plot)
dev.off()