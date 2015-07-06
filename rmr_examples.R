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

# Logistic Regression
library(rmr2)

logistic.regression = 
  function(input, iterations, dims, alpha){
    
    ## Map function- makes a subset grid
    lr.map =  function(., M) {
      Y = M[,1] 
      X = M[,-1]
      keyval(
        1,
        Y * X * 
          g(-Y * as.numeric(X %*% t(plane))))
    }
    ## Reduce Function sum the dubset grids contribution
    lr.reduce = function(k, Z) {
      keyval(k, t(as.matrix(apply(Z,2,sum))))
    }
    
    
    ## Sigmoid Function
    g = function(z) {
      1/(1 + exp(-z))
    }
    #A vector to hold coefficients
    plane = t(rep(0, dims))
    
    #Iterating 
    for (i in 1:iterations) {
      gradient = 
        values(
          from.dfs(
            mapreduce(
              input,
              map = lr.map,     
              reduce = lr.reduce,
              combine = TRUE)))
      plane = plane + alpha * gradient }
    plane }

test.size = 10^5
eps = rnorm(test.size)
testdata = 
  to.dfs(
    as.matrix(
      data.frame(
        y = 2 * (eps > 0) - 1,
        x1 = 1:test.size, 
        x2 = 1:test.size + eps)))

logistic.regression(testdata, 3, 2, 0.05)

## K-means
#A wrapper function
kmeans.mr = 
  function(
    P, 
    num.clusters, 
    num.iter, 
    combine, 
    in.memory.combine) {
    #Calculate the distances
    dist.fun = 
      function(C, P) {
        apply(
          C,
          1, 
          function(x) 
            colSums((t(P) - x)^2))}
    # Map function, samples different chunks of data
    kmeans.map = 
      function(., P) {
        nearest = {
          if(is.null(C)) 
            sample(
              1:num.clusters, 
              nrow(P), 
              replace = TRUE)
          else {
            D = dist.fun(C, P)
            nearest = max.col(-D)}}
        if(!(combine || in.memory.combine))
          keyval(nearest, P) 
        else 
          keyval(nearest, cbind(1, P))}
    
    
    # Reduce function, accumulates distances from map function
    kmeans.reduce = {
      if (!(combine || in.memory.combine) ) 
        function(., P) 
          t(as.matrix(apply(P, 2, mean)))
      else 
        function(k, P) 
          keyval(
            k, 
            t(as.matrix(apply(P, 2, sum))))}
    
    # Iterating function
    C = NULL
    for(i in 1:num.iter ) {
      C = 
        values(
          from.dfs(
            mapreduce(
              P, 
              map = kmeans.map,
              reduce = kmeans.reduce)))
      if(combine || in.memory.combine)
        C = C[, -1]/C[, 1]
      
      if(nrow(C) < num.clusters) {
        C = 
          rbind(
            C,
            matrix(
              rnorm(
                (num.clusters - 
                   nrow(C)) * nrow(C)), 
              ncol = nrow(C)) %*% C) }}
    C}

#Creating example
set.seed(3)
P = 
  do.call(
    rbind, 
    rep(
      list(
        matrix(
          rnorm(10, sd = 10), 
          ncol=2)), 
      20)) + 
  matrix(rnorm(200), ncol =2)

plot(P)
outcome=    kmeans.mr(
  to.dfs(P),
  num.clusters = 4, 
  num.iter = 5,
  combine = FALSE,
  in.memory.combine = FALSE)

#compare mapreduce to kmeans function
clust_ind=apply(P,1,function(x){
  sub_dist=apply(outcome,1,function(y){
    sqrt((y[1]-x[1])^2+(y[2]-x[2])^2)
  })
  which(sub_dist==min(sub_dist))
})
P=as.data.frame(P)
P[,3]=clust_ind


k=kmeans(as.matrix(P[,1:2]),4)
P[,4]=k$cluster
table(P$V3,P$V4)
library(ggplot2)
ggplot(P)+geom_point(aes(x=V1,y=V2),colour=P[,3])
ggplot(P)+geom_point(aes(x=V1,y=V2),colour=P[,4])

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



