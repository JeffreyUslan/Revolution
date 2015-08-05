## extract the names of the possible options:
names(rxOptions())

## extract the sample data directory:
rxGetOption("sampleDataDir")

## view the current value of the reportProgress option
rxGetOption("reportProgress")

## set the value of the reportProgress option to 0
rxOptions(reportProgress = 0)