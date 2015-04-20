best <- function(state, outcome) {
  
  #definitions
  outcomeCols <- c('Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack',
                       'Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure',
                       'Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia')
  
  outcomeTypes <- c('heart attack','heart failure','pneumonia')
  
  hospitalColumnName <- "Hospital.Name"
  
  ## Read outcome data
  outcomeFile <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  
  ## Check that state and outcome are valid
  if (!state %in% outcomeFile[,7]) {
    stop("invalid state")
  }
    
  if (!outcome %in% outcomeTypes) {
    stop("invalid outcome")
  }
  
  outcomeFile <- outcomeFile[outcomeFile$State==state,]
  
  suppressWarnings(outcomeFile[, outcomeCols ] <- sapply(outcomeFile[, outcomeCols], as.numeric))
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  if (outcome == outcomeTypes[1]) {
    
    as.character(head(outcomeFile[order(outcomeFile$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack), hospitalColumnName], n=1))
  
  } else if(outcome == outcomeTypes[2]) {
    
    as.character(head(outcomeFile[order(outcomeFile$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure), hospitalColumnName], n=1))
  
  } else if(outcome == outcomeTypes[3]){
  
    as.character(head(outcomeFile[order(outcomeFile$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia), hospitalColumnName], n=1))
  }
}