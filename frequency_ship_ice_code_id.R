#frequency_ship_ice_code_id.R

setwd("C:/Data/Arctic/ArcticOptions/tables")
newdata = read.csv("C:/Users/gfiske/Downloads/ice_ship_by_code_id.csv", header=T, sep=",")
y <- as.data.frame(table(newdata$code_id))

#write it out to CSV
write.csv(y, file = "ship_ice_freq_code_id.csv")
