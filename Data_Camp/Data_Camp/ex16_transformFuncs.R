## Compute the summary statistics
(csSummary <- rxSummary(~ creditScore , data = mortData))

## Extract the mean and std. deviation
meanCS <- csSummary$sDataFrame$Mean[1]
sdCS <- csSummary$sDataFrame$StdDev[1]

## Create a function to compute the scaled variable
scaleCS <- function(mylist){
  mylist[["scaledCreditScore"]] <- (mylist[["creditScore"]] - myCenter) / myScale
  return(mylist)
}

## Run it with rxDataStep
myMortData <- "myMD.xdf"
rxDataStep(inData = mortData, outFile = myMortData,
           transformFunc = scaleCS,
           transformObjects = list(myCenter = meanCS, myScale = sdCS)
           )

## Check the new variable:
rxGetVarInfo(myMortData)
rxSummary( ~scaledCreditScore, data = myMortData)