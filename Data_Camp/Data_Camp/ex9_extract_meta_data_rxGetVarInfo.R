## get variable information for the dataset
djiVarInfo <- rxGetVarInfo(djiXdf)
names(djiVarInfo)

## extract information about the closing cost variable
(closeVarInfo <- djiVarInfo[["Close"]])
## get the class of the closeVarInfo object:
class(closeVarInfo)
## examine the structure of the closeVarInfo object:
str(closeVarInfo)

## extract the global maximum of the closing cost variable:
closeMax <- closeVarInfo[["high"]]