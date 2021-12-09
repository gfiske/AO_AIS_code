#Greg Fiske
#June 2017
#plots Ship/Ice interactions by month in a bin2d plot

#THIS NEVER WORKED,
#I needed another dimension

#set working directory
setwd("C:/Data/Arctic/ArcticOptions/tables")
rm(list = ls())

library(foreign)
library(ggplot2)

rs <- dbGetQuery(con, 'select date_trunc(\'hour\', timestamp) as day, sum("WTG1_R_InvPwr_kW")/6 as power from frames group by date_trunc(\'hour\', timestamp) order by 1 desc limit 720;')

#read table
mydata = read.csv("C:/Data/Arctic/ArcticOptions/tables/spJoined_merged_w_Ice_dissolved2.csv", header=T, sep=",")
#subset only the pertinent fields
myvars <- c("yd", "SUM_ice")
newdata <- subset(mydata[myvars])

#create the bin2d plot
png('ShipIce_bin2dplot.png', width = 850, height = 600)
ggplot(newdata, aes(x=day, y=power), xaxt = "n") + geom_bin2d() + labs(y = "kwh") + labs(title = "Turbine production last 30 days")
dev.off()

d <- ggplot(newdata, aes(as.numeric(newdata$yd), newdata$SUM_ice)) + xlim(4, 10) + ylim(4, 10)
d + geom_bin2d()


