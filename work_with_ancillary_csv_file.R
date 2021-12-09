#work with Ancillary csv file after it is joined with 4k tile

#fix the original file
rm(list = ls())
setwd("C:\\Data\\Crap\\output")
mydata = read.csv("AIS_w_ancillary_spJoined.csv", header=T, sep=",")
myvars <- c("time", "mmsi", "nav", "rot", "truehead", "long", "lat", "name", "destinatio", "type", "length", "width", "draught", "mid", "flag", "code_id")
newdata <- subset(mydata[myvars]) #the first column was crap
newdata2 <- newdata[-1,] #the second record looked like it was crap
write.csv(newdata2, file = "AIS_w_ancillary_spJoined2.csv")

#attempt at cleaning up the table (ie removing blanks and making them true NAs)
rm(list = ls())
setwd("C:\\Data\\Crap\\output")
mydata = read.csv("AIS_w_ancillary_spJoined2.csv", stringsAsFactors=F, header=T, sep=",")
#mydata[is.na(mydata)] <- 'null'
mydata[mydata==""] <- NA
write.csv(mydata, file = "AIS_w_ancillary_spJoined3.csv")


#with Tina's help ID the offending character
mydata_new <- unlist(mydata)
v <- paste(mydata_new, collapse="")
v[528601309]

# a replacement line of code
mydata_new <- replace(mydata, is.null(mydata), "null")

#as it turns out, I think using bash to merge the csv files causes error in the output merged file
#hence
rm(list = ls())
setwd("C:\\Data\\Crap\\output")
files <- list.files(pattern = "*.csv$")

DF <-  read.csv(files[1])
for (f in files[-1]) DF <- rbind(DF, read.csv(f))   
write.csv(DF, "AIS_w_ancillary_spJoined4.csv",row.names=FALSE, quote=FALSE)
myvars <- c("time", "mmsi", "nav", "rot", "truehead", "long", "lat", "name", "destinatio", "type", "length", "width", "draught", "mid", "flag", "code_id")
DF2 <- subset(DF[myvars]) #the first column was crap
write.csv(DF2, "AIS_w_ancillary_spJoined5.csv",row.names=T, quote=T)
#view a specific set of records
mysub <- subset(DF2, DF$time == '8/16/2012 0:00:00')

mydata = read.csv("AIS_w_ancillary_spJoined5.csv", stringsAsFactors=F, header=T, sep=",")

#that didn't work either, I ended up mergeing all the files in python and making sure each row was good during the merge
rm(list = ls())
setwd("C:\\Data\\Crap\\output")
mydata = read.csv("main.csv", stringsAsFactors=F, header=T, sep=",")
mysub <- subset(mydata, mydata$time == '8/16/2012 0:00:00')
