#addFirst3.R
#add first 3 country code value to ship/ice interaction table
#join to mmsi flag LU table

#this only worked if I used data.table - a recommendation of Tina's
#The base write.csv tried to make a 250gb output table 

rm(list = ls())
library(data.table)
setwd("C:/Data/Arctic/ArcticOptions/tables")

#read in the ice joined table using fread
#mydata = fread("C:/Data/Arctic/ArcticOptions/tables/ice_joined_AllYears.csv", header=T, sep=",")
mydata = fread("C:/Data/Arctic/ArcticOptions/tables/full_location_table_Oct_2017.csv", header=T, sep=",")
mydata$MMSI3 <- as.data.frame(substr(mydata$mmsi, 1,3))
dim(mydata);

#this didn't work
#join the LU table with flag info
myjoindata <- fread("C:/Data/Arctic/ArcticOptions/tables/first_3_MMSI_flag_code_LU_table.csv", header=T, sep=",")
joined <- merge(mydata, myjoindata, by="MMSI", all = TRUE)
dim(joined)

#write output 
fwrite(mydata, file = "ice_joined_AllYears_w_flag.csv")
#appears to have only done a partial join, wtf?
