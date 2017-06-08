#AIS_to_CSV.R

#The purpose of this script is to convert raw "|" AIS data from SpaceQuest to CSV format for integration in a GIS
#raw files are purged of records with no spatial location and duplicate records
#gfiske Feb 2017

#set input output
rm(list = ls())
indir <- "/mnt/gcs-bucket/decoded/"
outdir <- "/mnt/gcs-bucket/csv/"  

# find all psv files
psvfiles <- list.files(indir, "*.psv$", full.names = T)

# strip off the .psv
outfiles <- unlist(lapply(psvfiles, function(x) unlist(strsplit(x, ".psv"))[1]))

#keep a count
mycount <- 0

# Loop through each file and remove data with no location data and duplicate records
for (i in psvfiles) {
  mydata = read.csv(i, header=T, sep="|")
  #subset only the pertinent fields
  myvars <- c("mmsi", "rot", "satellite_timestamp", "true_heading", "x", "y")
  newdata <- subset(mydata[myvars])
  #remove non-spatial records
  newdata <- subset(newdata, newdata$x != 181.000000)
  #remove duplicates
  newdata <- newdata[!duplicated(newdata),]
  #write out to csv
  out.csv <- paste0(outdir, unlist(strsplit(basename(i), ".psv"))[1], ".csv")
  mycount <- mycount + nrow(newdata)
  write.csv(newdata, file = out.csv)
  } 

#write some summary stats
myfile <- file(paste(outdir, "summarystats.txt"))
writeLines(c("Total records: ",mycount), myfile)
close(myfile)
