rm(list = ls())

library(readxl)
library(vars)
library(MTS)
library(crypto)

setwd("~/Dropbox/Cointegration Test/Code")

#List of all cryptocurrencies from coinmarketcap
list = crypto_list(coin = NULL, start_date = NULL, end_date = NULL,
                   coin_list = NULL)

#Scrape the largest N currencies
N = 50
data = list()
for (i in 1:N){
  data[[i]] = crypto_history(coin = list$name[i], limit = 1, start_date = '20150101',end_date = NULL, coin_list = NULL, sleep = NULL)
}

#Merge 50 largest currencies

#Select number of observations
T = 730

price = rep(0,T)

for (i in 1:N){
  D = data[[i]]
  if (nrow(D)>T){
    price = cbind(price,D$close[(nrow(D)-T+1):nrow(D)])
  }
}
price = price[,-1]

#Exclude those CC with T_i<T
colnames(price) = list$symbol[1:N][-c(9,11,15,22:26,28,29,32,34:36,39:46,48,49)]

#Exclude those CC tied to the dollar
price = price[,-c(4)]
logprice = log(price)

date = seq.Date(from = as.Date("2017/10/5",format = "%Y/%m/%d"), by = "day", length.out = 730)
logprice = cbind(date,as.data.frame(logprice))
price = cbind(date,as.data.frame(price))

write.csv(file="price.csv",price)
write.csv(file="logprice.csv",logprice)