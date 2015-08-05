# Regression for airSpeed based on departure delay
myLMobj <- rxLinMod(formula = airSpeed ~ DepDelay, 
         data = myAirlineXdf,
         rowSelection = (airSpeed > 50) & (airSpeed < 800))
summary(myLMobj)