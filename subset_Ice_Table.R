#subset_Ice_Table.R
#used to subset bad columns
#and later
#used to replace bad characters in output Ice Joined csv data

rm(list = ls())
#set output
outdir <- "C:/Data/Crap/"

#read table
mydata = read.csv("C:/Data/Crap/spJoined_merged_w_Ice.csv", header=T, sep=",")

#subset only the pertinent fields
myvars <- c("time", "mmsi", "long", "lat", "type", "length", "width", "draught", "code_id", "yd", "region", "ice")
newdata <- subset(mydata[myvars])
#write out to csv
write.csv(newdata, file = "C:/Data/Arctic/ArcticOptions/tables/spJoined_merged_w_Ice_subset.csv")

#find bad characters and replace them (with some help from Tina)
mydata_new2 <- as.data.frame(lapply(mydata, function(x) gsub(" ", "|", x)))
write.csv(mydata_new2, file = "C:/Data/Crap/spJoined_merged_w_Ice_cleaned.csv")

#next, BQ complainded about empty rows, so I tried to find them
mydata_new = read.csv("C:/Data/Crap/spJoined_merged_w_Ice_cleaned2.csv", header=T)
mydata_new4 <- mydata_new[!apply(mydata_new == "", 1, all),]

#turns out, there were still commas in some of the fields, so I continue to try to clean the data and then import it.
#In ArcGIS, I removed all of these characters and it finally worked: "',