corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  source("complete.R")
  options(digits=4)
  
  completes <- complete(directory)
  
  casesGreaterThsld <- completes[completes$nobs > threshold,1]
  
  filenames <- paste(directory, "/", list.files(directory), sep="")
 
  corrs <- rep(NA,length(casesGreaterThsld))
  
  for (i in casesGreaterThsld) {
    
    selected <- read.csv(filenames[i])
    
    completes <- complete.cases(selected)
    
    sulfateData <- selected[completes, "sulfate"]
    
    nitrateData <- selected[completes, "nitrate"]
    
    corrs[i] <- cor(sulfateData, nitrateData)
    
  }
  
  corrs[complete.cases(corrs)]
  
}