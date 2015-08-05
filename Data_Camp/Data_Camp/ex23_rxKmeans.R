## Examine the mortData dataset
rxGetInfo(mortData, getVarInfo = TRUE)

## set up a path to a new xdf file
myNewMortData = "myMDwithKMeans.xdf"
## run k-means:
KMout <- rxKmeans(formula = ~ ccDebt + creditScore + houseAge, 
         data = mortData,
         outFile = myNewMortData,
         rowSelection = year == 2000,
         numClusters  = 4,
         writeModelVars = TRUE)
print(KMout)

## Examine the variables in the new dataset:
rxGetInfo(myNewMortData, getVarInfo = TRUE)

## Summarize the cluster variable:
rxSummary(~ F(.rxCluster), data = myNewMortData)

## read into memory 10% of the data:
mydf <- rxXdfToDataFrame(myNewMortData,
                         rowSelection = randSamp == 1,
                         varsToDrop = "year",
                         transforms = list(randSamp = sample(10, size = .rxNumRows, replace = TRUE)))

## visualize the clusters:
plot(mydf[-1], col = mydf$.rxCluster)
