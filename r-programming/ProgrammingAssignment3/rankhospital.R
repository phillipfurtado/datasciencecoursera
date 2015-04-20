rankhospital <- function(state, outcome, num = "best") {
  
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
  
  if (num == "best") {
    num <- 1
    desc <- FALSE    
  } else if(num=="worst") {
    num <- 1
    desc <- TRUE  
  } else if(is.numeric(num)) {
    desc <- FALSE
  } else {
    stop("invalid num")
  }
  
  outcomeFile <- outcomeFile[outcomeFile$State==state,]
  
  if(num > nrow(outcomeFile)){
    return(NA)
  }
  
  suppressWarnings(outcomeFile[, outcomeCols ] <- sapply(outcomeFile[, outcomeCols], as.numeric))
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  if (outcome == outcomeTypes[1]) {
    
    as.character(tail(head(outcomeFile[order(outcomeFile$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, outcomeFile$Hospital.Name, decreasing = desc), hospitalColumnName], n=num), n=1))
    
  } else if(outcome == outcomeTypes[2]) {
    
    as.character(tail(head(outcomeFile[order(outcomeFile$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, outcomeFile$Hospital.Name, decreasing = desc), hospitalColumnName], n=num), n=1))
    
  } else if(outcome == outcomeTypes[3]){
    
    as.character(tail(head(outcomeFile[order(outcomeFile$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, outcomeFile$Hospital.Name, decreasing = desc), hospitalColumnName], n=num), n=1))
  }
  
}