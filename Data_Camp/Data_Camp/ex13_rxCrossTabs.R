## Compute the the summed volume for each day of the week:
rxCrossTabs(formula = Volume ~ DayOfWeek, data = djiXdf)

## Compute the the summed volume for each day of the week for each month:
rxCrossTabs(formula = Volume ~ F(Month):DayOfWeek, data = djiXdf)

## Compute the the average volume for each day of the week for each month:
rxCrossTabs(formula = Volume ~ F(Month):DayOfWeek, data = djiXdf, means = TRUE)

## Compute the the average closing price for each day of the week for each month, using volume as frequency weights
rxCrossTabs(formula = Close ~ F(Month):DayOfWeek, data = djiXdf, means = TRUE, fweights  = "Volume")