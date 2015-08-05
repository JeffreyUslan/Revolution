# Get basic information about your data
rxGetInfo(data = myAirlineXdf, 
          getVarInfo = TRUE,
          numRows  = 10)

## Summarize the variables corresponding to actual elapsed time, time in the air, departure delay, flight Distance.
rxSummary(formula = ~ ActualElapsedTime + AirTime + DepDelay + Distance, 
          data  = myAirlineXdf)

# Histogram of departure delays
rxHistogram(formula = ~DepDelay, 
            data = myAirlineXdf)

# Use parameters similar to a regular histogram to zero in on the interesting area
rxHistogram(formula = ~DepDelay, 
            data = myAirlineXdf, 
            xAxisMinMax = c(-100, 400), 
            numBreaks = 500,
            xNumTicks = 10)