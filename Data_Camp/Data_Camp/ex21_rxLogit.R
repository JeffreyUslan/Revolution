# look at the meta data
rxGetInfo(mortData , getVarInfo = TRUE)

# Construct the logit model
logitModel <- rxLogit(formula = default ~ houseAge + F(year) + ccDebt + creditScore + yearsEmploy, 
                       data = mortData )

# Summarize the result contained in logitModel1
summary(logitModel)