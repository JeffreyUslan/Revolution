# Conversion to miles per hour
rxDataStep(inData = myAirlineXdf, 
         outFile = myAirlineXdf, 
         varsToKeep = c("airSpeed"),
	       transforms = list(airSpeed = airSpeed * 60),
         overwrite=TRUE)

# Histogram for airspeed after conversion
rxHistogram(formula =~airSpeed, data = myAirlineXdf)