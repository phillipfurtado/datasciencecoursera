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

aggregated <- aggregate(Emissions ~ year, onlyBaltimore, sum)

png('plot2.png')
barplot(height=aggregated$Emissions/10^6, 
        names.arg=aggregated$year, 
        xlab="Year", 
        ylab="PM2.5 emission (10^6 Tons)",
        main="Total PM2.5 emissions by year in Baltimore City")
dev.off()