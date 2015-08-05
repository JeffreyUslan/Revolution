# Summarize arrival delay for each day of the week.
rxSummary(formula =ArrDelay~  DayOfWeek, data = myAirlineXdf)

## Vizualize the arrival delay histogram
rxHistogram(formula = ~ArrDelay, data = myAirlineXdf)