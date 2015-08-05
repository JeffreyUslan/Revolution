## summarize model first
summary(myLM2)

## path to new dataset storing predictions
myNewADS <- "myNEWADS.xdf"

## generate predictions
rxPredict(modelObject = myLM2, data = myAirlineXdf, 
          outData = myNewADS, 
          writeModelVars = TRUE)
## get information on the new dataset
rxGetInfo(myNewADS, getVarInfo = TRUE)

## Generate residuals.
rxPredict(modelObject = myLM2, data = myAirlineXdf, 
          outData = myNewADS, 
          writeModelVars = TRUE, 
          computeResiduals = TRUE, 
          overwrite = TRUE)
## get information on the new dataset
rxGetInfo(myNewADS, getVarInfo = TRUE)