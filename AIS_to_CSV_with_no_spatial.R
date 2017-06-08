#AIS_to_CSV_with_null_spatial.R

#The purpose of this script is to count how many records in the raw "|" AIS data have no spatial location information
#gfiske May 2017

#set input output
rm(list = ls())
#indir <- "/mnt/gcs-bucket/decoded/"
indir <- "/mnt/gcs-bucket/decoded/ancillary_data/"
#outdir <- "/mnt/gcs-bucket/csv/"  

#read one table as a test
#mydata = read.csv("/mnt/gcs-bucket/decoded/ancillary_data/2011-01-15-p0001.csv", header=T, sep=",")

# find all the csv files
csvfiles <- list.files(indir, "*.csv", full.names = T)

#keep a count
mycount <- 0

# Loop through each file and count records with no spatial info
for (i in csvfiles) {
  mydata = read.csv(i, header=T, sep=",")
  #subset only the pertinent fields
  myvars <- c("time","mmsi","nav","rot","truehead","long","lat","name","destination","type","length","width","draught","mid","flag")
  newdata <- subset(mydata[myvars])
  #identify records with non-spatial records
  newdata <- subset(newdata, newdata$long = 181.000000)
  #or with spatial records
  #newdata <- subset(newdata, newdata$long < 181.000000)
  mycount <- nrow(newdata) + mycount
  }

#write some summary stats
myfile <- file(paste(indir, "no_spatial_stats.txt"))
writeLines(c("Total records: ",mycount), myfile)
close(myfile)
print(mycount)

