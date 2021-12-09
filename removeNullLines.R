
#attempt to remove empty lines from csv files
#applied to my BQ exercises for the panArctic Options project

rm(list = ls())
setwd("C:/Data/Crap")
myData = read.csv("C:/Data/Crap/spJoined_merged_w_Ice_cleaned2.csv", header=T, sep=",")


##NONE OF THE BELOW WORKED!

#clean
#myData= myData.applymap(lambda myData: myData.replace("\r"," "))
#myData= myData.applymap(lambda myData: myData.replace("\n"," "))


newdata <- subset(myData, OBJECTID < 10000)

fart <- as.data.frame(lapply(newdata, function(y) gsub("\r?\n|\r", " ", newdata)))

library(stringr)
fart2 <- str_replace_all(newdata, "[\r\n]" , "")
