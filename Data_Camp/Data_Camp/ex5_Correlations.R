# Correlation for departure delay, arrival delay, and air speed
rxCor(formula = ~ DepDelay + ArrDelay + airSpeed,
      data = myAirlineXdf,
      rowSelection = (airSpeed > 50) & (airSpeed < 800))