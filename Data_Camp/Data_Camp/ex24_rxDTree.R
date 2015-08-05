## regression tree:
regTreeOut <- rxDTree(default ~ creditScore + ccDebt + yearsEmploy + houseAge ,
                      rowSelection = year == 2000,
                      data = mortData,
                      maxdepth = 5)
## print out the object:
print(regTreeOut)

## plot a dendrogram, and add node labels:
plot(rxAddInheritance(regTreeOut))
text(rxAddInheritance(regTreeOut))

## Another visualization:
# library(RevoTreeView)
# createTreeView(regTreeOut)

## predict values:
myNewData = "myNewMortData.xdf"
rxPredict(regTreeOut,
          data = mortData,
          outData = myNewData,
          writeModelVars = TRUE,
          predVarNames = "default_RegPred")

## visualize ROC curve
rxRocCurve(actualVarName = "default",
           predVarNames = "default_RegPred",
           data = myNewData)