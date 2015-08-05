## Simple bivariate line plot:
rxLinePlot(Close ~ DaysSince1928, data = djiXdf)

## Using different panels for different days of the week:
rxLinePlot(Close ~ DaysSince1928 | DayOfWeek, data = djiXdf)

## Using different groups.
rxLinePlot(Close ~ DaysSince1928, groups  = DayOfWeek, data = djiXdf)

## Simple bivariate line plot, after taking the log() of the ordinate (y) variable.
rxLinePlot(log(Close) ~ DaysSince1928, data = djiXdf)