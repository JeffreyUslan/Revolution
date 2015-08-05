## Get information on mortData
rxGetInfo(mortData)

## Set up my personal copy of the data:
myMortData <- "myMD.xdf"

## Create the transform
rxDataStep(inData = mortData, outFile = myMortData,
           transforms = list(highDebtRow = ccDebt > 8000)
  )
## Get the variable information
rxGetVarInfo(myMortData)
## Get the proportion of values that are 1.
rxSummary( ~ highDebtRow, data = myMortData)

## Compute multiple transforms!
rxDataStep(inData = myMortData, outFile = myMortData,
           transforms = list(
             newHouse = houseAge < 10,
             ccsXhd = creditScore * highDebtRow 
             ),
           append = "cols",
           overwrite = TRUE
  )