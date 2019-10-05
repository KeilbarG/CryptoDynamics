rm(list = ls())

setwd("~/Dropbox/Cointegration Test/Code")

logprice = as.matrix(read.csv("logprice.csv")[,-c(1,2)])
date = as.Date(read.csv("logprice.csv")[,2])

plot(logprice[,1]~date,type="l",ylim=c(-7,10),xlab="",ylab="",lwd=2)
lines(logprice[,2]~date,col="red",lwd=2)
lines(logprice[,3]~date,col="blue",lwd=2)
lines(logprice[,4]~date,col="green",lwd=2)
lines(logprice[,5]~date,col="purple",lwd=2)
for(i in 5:20){lines(logprice[,i]~date,col="grey")}
