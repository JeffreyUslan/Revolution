# https://github.com/RevolutionAnalytics/rmr2/blob/master/docs/tutorial.md
library(rmr2)
rmr.options(backend="local")

##Squaring
#normal
small.ints = 1:1000
cbind(small.ints,sapply(small.ints, function(x) x^2))

#mapreduce
small.ints = to.dfs(1:1000)
from.dfs(
  mapreduce(
  input = small.ints, 
  map = function(k, v) cbind(v, v^2)
  )
)



##Length Counting
# send groups ID (randomly generated from a binomial) to Hadoop filesystem
groups = rbinom(32, n = 15, prob = 0.4)
t=tapply(groups, groups, length)


groups = to.dfs(groups)
# run a mapreduce job
## map: key value is the group id, value is 1
## reduce: count the number of observations in each group
## then, retrieve it from Hadoop filesystem
output = from.dfs(
                  mapreduce(input = groups, 
                            map = function(., v) 
                                keyval(v, 1), 
                            reduce = function(k, vv)  
                                keyval(k, length(vv))
                   )
                  )
# print results
## keys: group IDs
## values: results of reduce job (<em>i.e.</em>, frequency)
t(data.frame(key=output$key,val=output$val))
t

#broken ##Word Count


romeo_and_juliet=readLines("./romeo_and_juliet.txt",skipNul = TRUE)
romeo_and_juliet=as.character(sapply(romeo_and_juliet,function(x) x=iconv(x, "latin1", "ASCII", sub="")))
romeo_and_juliet=as.character(sapply(romeo_and_juliet,function(x) x=gsub("[^[:alpha:] ]", "",x)[[1]]))
romeo_and_juliet=as.character(sapply(romeo_and_juliet,tolower))






#function that encapsulates the job
#     Maps what a word is
    wc.map =  function(k, lines) {
        words.list=strsplit(x = lines,split = " ")
        words=unlist(words.list)
        keyval(words, 1)}
#The reducing function to count the words
    wc.reduce = function(words, counts ) {
        keyval(words, sum(counts))}
# combine the map function and the reduce function
 wordcount=function(input,output=NULL){
    mapreduce(
      input = input,
      output = output,

      map = wc.map,
      reduce = wc.reduce,
      combine = TRUE)
    #       input.format = "text",
}


outcome=from.dfs(wordcount(to.dfs(keyval(NULL,romeo_and_juliet))))
t=data.frame(key=outcome$key,val=as.numeric(outcome$val))
t[,1]=as.character(t[,1])
lengths=sapply(t[,1],nchar)
t=t[which(lengths>4),]
ord=order(t$val,decreasing=TRUE)
t[ord,][1:50,]

##Linear Least Squares

solve(t(X)%*%X, t(X)%*%y)

X = matrix(rnorm(2000), ncol = 10)
X.index = to.dfs(cbind(1:nrow(X), X))
y = as.matrix(rnorm(200))


Sum = 
  function(., YY) 
    keyval(1, list(Reduce('+', YY)))


XtX = 
  values(
    from.dfs(
      mapreduce(
        input = X.index,
        map = 
          function(., Xi) {
            yi = y[Xi[,1],]
            Xi = Xi[,-1]
            keyval(1, list(t(Xi) %*% Xi))},
        reduce = Sum,
        combine = TRUE)))[[1]]

Xty = 
  values(
    from.dfs(
      mapreduce(
        input = X.index,
        map = function(., Xi) {
          yi = y[Xi[,1],]
          Xi = Xi[,-1]
          keyval(1, list(t(Xi) %*% yi))},
        reduce = Sum,
        combine = TRUE)))[[1]]

solve(XtX, Xty)



