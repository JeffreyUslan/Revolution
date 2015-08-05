# Declare the file paths for the csv and xdf files
myAirlineCsv <- file.path(rxGetOption("sampleDataDir"), "2007_subset.csv")
myAirlineXdf <- "2007_subset.xdf"

# Use rxImport to import the data into xdf format
rxImport(inData = myAirlineCsv, outFile = myAirlineXdf, overwrite = TRUE)
list.files()