#circularHistogram.R
#shows unique ships by longitude

rm(list = ls())
library(ggplot2)

#read table
mydata = read.csv("C:/Data/Crap/test3.csv", header=T, sep=",")
#mydata = read.csv("C:/Data/Arctic/ArcticOptions/tables/spJoined_merged_w_Ice_subset.csv", header=T, sep=",")

# Basic histogram
#ggplot(mydata, aes(x = year, y = ships, fill = cat)) + geom_bar(stat = "identity")
ggplot(mydata, aes(x = time, y = mmsi, fill = cat)) + geom_bar(stat = "identity")
plot(mydata$time, mydata$mmsi)

# Radial histogram
ggplot(mydata, aes(x = cat, y = ships, fill = year)) +
  coord_polar(theta = "x", start = 6.8, direction = -1) +
  geom_bar(stat = "identity") +
  #geom_bar() +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.text=element_text(size=14),
        legend.title=element_text(size=16),
        legend.text=element_text(size=14))

