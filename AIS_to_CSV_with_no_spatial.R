#AIS_to_CSV_with_null_spatial.R

#The purpose of this script is to count how many records in the raw "|" AIS data have no spatial location information

#set input output
rm(list = ls())
#indir <- "/mnt/gcs-bucket/decoded/"
indir <- "C:/Data/Crap/AIS_backup_March2017/decoded/"
#outdir <- "/mnt/gcs-bucket/csv/"  

# find all psv files
psvfiles <- list.files(indir, "*.psv$", full.names = T)

#keep a count
mycount <- 0

# Loop through each file and count records with no spatial info
for (i in psvfiles) {
  mydata = read.csv(i, header=T, sep="|")
  #subset only the pertinent fields
  myvars <- c("mmsi", "rot", "satellite_timestamp", "true_heading", "x", "y")
  newdata <- subset(mydata[myvars])
  #identify records with non-spatial records
  newdata <- subset(newdata, newdata$x == 181.000000)
  mycount <- nrow(newdata) + mycount
  }

#write some summary stats
myfile <- file(paste(indir, "no_spatial_stats.txt"))
writeLines(c("Total records: ",mycount), myfile)
close(myfile)
print(mycount)

