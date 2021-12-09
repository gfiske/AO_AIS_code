#I wrote this to check my count stats of Glenn's data for years 2017-18 via Google BQ
#first step merge all CSVs
#second step, make a shapefile of the results in Arc and then count unique MMSIs per year
#April 2019 gfiske

#Ultimately I shit canned this approach as there were so many warnings due to errors in the tables

rm(list = ls())

require(data.table)

multmerge = function(path){
  filenames=list.files(path=path, full.names=TRUE)
  rbindlist(lapply(filenames, fread))
}


path <- "C:/Data/Crap/newdatafromGlenn_bu"
myData <- multmerge(path)
write.csv(myData, file = "C:/Data/Crap/newdatafromGlenn.csv")
