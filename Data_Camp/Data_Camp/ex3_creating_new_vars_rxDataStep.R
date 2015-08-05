## Calculate an additional variable: airspeed (distance traveled / time in the air). 
rxDataStep(inData = myAirlineXdf, 
         outFile = myAirlineXdf, 
         varsToKeep = c("AirTime", "Distance"),
	       transforms = list(airSpeed = AirTime / Distance),
         append = "rows",
         overwrite = TRUE)

# Get Variable Information for airspeed
rxGetInfo(data = myAirlineXdf, 
          getVarInfo = TRUE,
          varsToKeep = "airSpeed")

# Summary for the airspeed variable
rxSummary(formula =~airSpeed, 
          data = myAirlineXdf)

# Construct a histogtam for airspeed
# We can use the xAxisMinMax argument to limit the X-axis.
rxHistogram(formula =~airSpeed, 
            data = myAirlineXdf
            )

rxHistogram(formula =~airSpeed, 
            data = myAirlineXdf,
            xNumTicks = 10,
            numBreaks = 1500,
            xAxisMinMax = c(0,12)
            )


            
