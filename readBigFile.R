#readBigFile.R

#read the entire AIS archive into R
library(data.table)

mydata <- fread('C:\\Data\\Crap\\AIS_backup_March2017\\ancillary_data\\merged_ancillary_data.csv')