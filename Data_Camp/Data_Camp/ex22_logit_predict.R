## Summarize the model
summary(logitModel)

## view the first few rows of observations
head(newData)

# Make predictions
dataWithPredictions <- rxPredict(modelObject = logitModel, data = newData, outData = newData, type = "response")

## view the predictions
dataWithPredictions