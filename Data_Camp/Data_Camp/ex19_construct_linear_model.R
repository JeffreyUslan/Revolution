## predict arrival delay by day of the week:
myLM1 <- rxLinMod( ArrDelay ~ DayOfWeek, data = myAirlineXdf)

## summarize the model
summary(myLM1)

## Use the transforms argument to create a factor variable associated with departure time "on the fly,"
## predict Arrival Delay by the interaction between Day of the week and that new factor variable.
myLM2 <- rxLinMod( ArrDelay ~ DayOfWeek:catDepTime, data = myAirlineXdf,
                   transforms  = list(
                     catDepTime = cut(CRSDepTime, breaks = seq(from = 5, to = 23, by = 2))
                     ),
                    cube = TRUE
                   )

## summarize the model
summary(myLM2)