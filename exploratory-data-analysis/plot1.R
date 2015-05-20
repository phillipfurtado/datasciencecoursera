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

aggregated <- aggregate(Emissions ~ year, NEI, sum)

png('plot1.png')
barplot(height=aggregated$Emissions/10^6, 
        names.arg=aggregated$year, 
        xlab="Year", 
        ylab="PM2.5 emission (10^6 Tons)",
        main="Total PM2.5 emissions by year")
dev.off()