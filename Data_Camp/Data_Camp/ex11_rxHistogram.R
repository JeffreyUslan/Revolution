## Numeric Variables
rxHistogram(~ Close , data = djiXdf)
## Categorical Variable:
rxHistogram(~ DayOfWeek, data = djiXdf)

## Different panels for different days of the week
rxHistogram(~ Close | DayOfWeek, data = djiXdf)

## Numeric Variables with a frequency weighting:
rxHistogram(~ Close, data = djiXdf, fweights  = "Volume")