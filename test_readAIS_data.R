#testing code only


rm(list = ls())
#set working directory
setwd("C:\\Users\\gfiske\\Downloads")


#read data table for last 365 days
mydata = read.csv("ancillary_data2009-12-12-p0001.csv", header=T, sep=",")

#Number of ships at first timestamp
crap = subset(mydata, mydata$V7 == 1475287200)
nrow(crap)

#Number of MMSI = 0 records
noMMSI = subset(mydata, mydata$V1 == 0)
nrow(noMMSI)

#view a few of the unix time records as dates
GMT1 <-   as.POSIXct(as.numeric(as.character(crap$V7)),origin='1960-01-01', tz = 'GMT')
Y <- sample(GMT1, 10, replace = FALSE)
print(Y)

#convert unix time to DateTime
mydata$Date <- as.POSIXct(as.numeric(as.character(mydata$V7)),origin='1960-01-01', tz = 'GMT')

#sort by MMSI
newdata <- mydata[order(mydata$V1),] 




#read new data from Glenn
setwd("C:\\Data\\Crap")
rm(list = ls())
#read data table for last 365 days
mydata = read.csv("ArcticSea.2016-8-1.ais.18.psv", header=T, sep="|")

#Number of MMSI = 0 records
##noMMSI = subset(mydata, mydata$mmsi == 80)
##nrow(noMMSI)
##noLoc = subset(mydata, mydata$x == 181.0000000)
##nrow(noLoc)

#remove duplicates code from Tina
dups <- mydata[!duplicated(mydata),]

myvars <- c("mmsi", "rot", "satellite_timestamp", "true_heading", "x", "y")
newdata <- subset(dups[myvars])
newdata <- subset(newdata, newdata$x != 181.000000)
