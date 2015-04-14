pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  filenames <- paste(directory, "/", list.files(directory), sep="")
  
  csvs <- lapply(filenames[id], read.csv, header = TRUE)
  
  merged_df <- do.call(rbind , csvs)
  
  meanData <- mean(merged_df[,c(pollutant)], na.rm=TRUE)

  format(round(meanData, 3), nsmall = 3) 

}