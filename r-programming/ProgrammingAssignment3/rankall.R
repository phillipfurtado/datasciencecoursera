rankall <- function(outcome, num = "best") {
  
  #definitions
  outcomeCols <- c('Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack',
                   'Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure',
                   'Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia')
  
  outcomeTypes <- c('heart attack','heart failure','pneumonia')
  
  hospitalColumnName <- "Hospital.Name"
  
  hospitals <- data.frame()
  
  ## Read outcome data
  outcomeFile <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
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
    
  ## For each state, find the hospital of the given rank
  for(st in unique(outcomeFile$State)) {
    
    outcomeFileTemp <- outcomeFile[outcomeFile$State==st,]
        
    suppressWarnings(outcomeFileTemp[, outcomeCols ] <- sapply(outcomeFileTemp[, outcomeCols], as.numeric))
       
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    if (outcome == outcomeTypes[1]) {
      
      hospitalrank <- as.character(tail(head(outcomeFileTemp[order(outcomeFileTemp$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, outcomeFileTemp$Hospital.Name, decreasing = desc), hospitalColumnName], n=num), n=1))
      df <- data.frame(hospital = hospitalrank, state = st)
      hospitals <- rbind(hospitals,df)
      
    } else if(outcome == outcomeTypes[2]) {
      
      hospitalrank <- as.character(tail(head(outcomeFileTemp[order(outcomeFileTemp$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, outcomeFileTemp$Hospital.Name, decreasing = desc), hospitalColumnName], n=num), n=1))
      df <- data.frame(hospital = hospitalrank, state = st)
      hospitals <- rbind(hospitals,df)
      
    } else if(outcome == outcomeTypes[3]){
      
      hospitalrank <- as.character(tail(head(outcomeFileTemp[order(outcomeFileTemp$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, outcomeFileTemp$Hospital.Name, decreasing = desc), hospitalColumnName], n=num), n=1))
      df <- data.frame(hospital = hospitalrank, state = st)
      hospitals <- rbind(hospitals,df)
    }
    
  } 
  
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  hospitals[order(as.character(hospitals$state)),]
}