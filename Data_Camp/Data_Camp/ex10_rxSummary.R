## Basic summary statistics:
rxSummary(formula  = ~ DayOfWeek + Close + Volume, data = djiXdf)

## Frequency weighted:
rxSummary( formula = ~ DayOfWeek + Close, data = djiXdf, fweights   = "Volume")

## Basic frequency count:
rxCrossTabs( formula = ~ DayOfWeek, data = djiXdf)