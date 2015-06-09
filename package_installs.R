library("devtools")
install.packages(c("Rcpp","RJSONIO","bitops","digest",
                   "functional","reshape2","stringr",
                   "plyr","caTools"))
# https://github.com/RevolutionAnalytics/RHadoop/wiki/Downloads
install.packages("C:/Users/Jeffrey/Downloads/rmr2_3.3.1.zip", repos = NULL,type="binary")
library(rmr2)
rmr.options(backend="local")
install.packages("C:/Users/Jeffrey/Downloads/rhdfs_1.0.8.zip", repos = NULL,type="binary")
Sys.setenv("HADOOP_CMD"="/usr/local/hadoop/bin/hadoop")
Sys.setenv("HADOOP_STREAMING"="/usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming-2.4.0.jar")

library(rhdfs)
# install.packages("C:/Users/Jeffrey/Downloads/rhbase_1.2.1.tar.gz", repos = NULL, type = "source")
# library(rhbase)
# install.packages("C:/Users/Jeffrey/Downloads/plyrmr_0.6.0.tar.gz", repos = NULL, type = "source")
# library(plyrmyr)
# install.packages("C:/Users/Jeffrey/Downloads/ravro_1.0.4.tar.gz", repos = NULL, type = "source")
# library(ravro)


