# Declare the file paths for the csv and xdf files
myAirlineCsv <- file.path(rxGetOption("sampleDataDir"), "AirlineDemoSmall.csv")
myAirlineXdf <- "ADS.xdf"

# Use rxImport to import the data into xdf format
rxImport(inData = myAirlineCsv, 
         outFile = myAirlineXdf, 
         overwrite = TRUE,
         colInfo = list( 
           DayOfWeek = list(
            type = "factor", 
            levels = c("Monday", "Tuesday", "Wednesday", 
                       "Thursday", "Friday", "Saturday", "Sunday")
            )
          )         
         )