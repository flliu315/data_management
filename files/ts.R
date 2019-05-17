mydata <- read.csv("~/Documents/data_management/data/yelusu.csv")#将excel格式的转化为 csv再读取
ts<-ts(mydata$Value,start=c(2009,4,17),end = c(2009,11,23),frequency = 212)
plot(ts)
rdate<-as.Date(yelusu$Date,"%m/%d/%y")# #  将数据格式转化为时间序列格式
plot(yelusu$Value~rdate,type="l", col="red")
axis(1,rdate,,format(rdate,"%m-%y"))
