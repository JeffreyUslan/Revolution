#####################################################
#####################################################
##
##		RevoScaleR Demo - Airline table
##
##		Hortonworks Sandbox Hadoop demo 
##		Using "Beside" Architecture
##
##
##		all column names imported as lower case
##
#####################################################
#####################################################


#####################################################
## 
## general definitions
##
#####################################################


## filenames, location, etc. 

OdbcConnString <- "DSN=Sample Hortonworks Hive DSN"

odbcDS <- RxOdbcData(sqlQuery = "SELECT * FROM airline",
                                connectionString=OdbcConnString,
                                stringsAsFactors=TRUE, 
						        useFastRead = TRUE,
						        rowsPerRead=150000)

csvFile <- "./Project0/airline.csv"
xdfFile <- "./Project0/airline.xdf"
system.time(rxImport(inData =csvFile , outFile=xdfFile , overwrite=TRUE))

#if(file.exists(xdfFile)) file.remove(xdfFile)						
							
rxImportToXdf(odbcDS, xdfFile,overwrite=TRUE)


#####################################################
## 
## Inspect the data
##
#####################################################

## get general information about the file and the variables in it
rxGetInfo(data=xdfFile, getVarInfo=TRUE,numRows=3)

## a summary of time and distance:
rxSummary(~arrdelay + depdelay + dayofweek, data=xdfFile)

## we can inspect them visually, too. A histogram of departure delays, for example:
rxHistogram(~depdelay, data=xdfFile)

## can use parameters similar to a regular histogram to zero in on the interesting area
rxHistogram(~depdelay, data=xdfFile, xAxisMinMax=c(50, 200), numBreaks=500,xNumTicks=10)


#####################################################
## 
## Analytics!
##
## Run a regression: 
##
#####################################################

## before you run a regression, run a correlation
rxCor(formula=~depdelay+arrdelay, data=xdfFile)


##  a linear regression:
system.time(reg1 <- rxLinMod(formula=arrdelay~depdelay, data=xdfFile,rowSelection=(arrdelay>0) & (arrdelay <800)))

summary(reg1)
#############################################

## a generalized linear model:
system.time(glm1 <- rxGlm(formula=arrdelay~depdelay, data=xdfFile))

summary(glm1)



#############################################
# Decision Tree
#############################################

system.time(tr1 <- rxDTree(formula=arrdelay~crsdeptime+depdelay, data=xdfFile))

summary(tr1)

################# this section requires RRE 7
########### picture the tree

#library(RevoTreeView)

#plot(createTreeView(tr1))