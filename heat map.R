?heatmap
class(mtcars)
#convert data frame to data matriz
mtcars_mat<-data.matrix(mtcars)

heatmap(mtcars_mat,
        scale="column",
        col=cm.colors(n=15))

#remove the dendrogram
heatmap(mtcars_mat,
        scale="column",
        Colv=NA)
#clean up the environment
rm(list=ls())

#using gplots
install.packages("gplots")
library(gplots)
?heatmap.2

#import data from the internet
rawdata<-read.csv("https://raw.githubusercontent.com/ab604/heatmap/master/leanne_testdata.csv")

#clean the data
