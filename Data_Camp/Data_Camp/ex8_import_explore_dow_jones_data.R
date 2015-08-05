## set up the variable that has the address of the relevant data file:
djiXdf <- file.path(rxGetOption("sampleDataDir"), "DJIAdaily.xdf")

## get information about that dataset:
rxGetInfo(data = djiXdf, getVarInfo = TRUE)