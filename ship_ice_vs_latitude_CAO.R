#ship_ice_vs_latitude.R
#plots the ship/ice interaction points vs latitude
#to see if they're moving north through time
#Oct 2017

#updated on Dec 11 2017 for the book chapter
#found this resource: http://www.everydayanalytics.ca/2014/09/5-ways-to-do-2d-histograms-in-r.html

rm(list = ls())
library(ggplot2)
setwd("C:/Data/Arctic/ArcticOptions/tables")

#read table
mydata = read.csv("C:/Data/Arctic/ArcticOptions/tables/ice_joined_CAO.csv", header=T, sep=",")

# Basic scatter plot
##ggplot(mydata, aes(x=justDate_Converted, y=y)) + geom_point()

#create a bin2d plot showing lat vs day and count
# png('ShipIce_Day_bin2dplot.png', width = 850, height = 600)
# ggplot(mydata, aes(x=yd, y=y), xaxt = "n") + 
#   geom_bin2d() +
#   labs(y = "lat") +
#   labs(x = "day") + 
#   labs(title = "Ship/Ice Interactions by Day")
# dev.off()

# Color housekeeping
library(RColorBrewer)
rf <- colorRampPalette(rev(brewer.pal(11,'Spectral')))
r <- rf(32)

# Filter for latitude values > 60 (there were only a few under 60)
##mydata2 <- subset(mydata, y > 60)

#create a bin2d plot showing lat vs year and count
#png('ShipIce_Year_bin2dplot.png', width = 1250, height = 800)
#svg(filename = "ShipIce_Year_bin2dplot.svg", width = 8.5, height = 8, pointsize = 12)
jpeg('ShipIce_Year_bin2dplot.jpg', width = 9, height = 7, units = 'in', res = 300)
ggplot(mydata, aes(x=year_field, y=y), xaxt = "n", fun = "quantile") + 
  geom_bin2d(bins = 8) +
  #scale_fill_gradientn(colours = r, trans="log") +
  #scale_fill_gradientn(colours = r) +
  #geom_bin2d(binwidth = c(1,3)) +
  labs(y = "latitude", size=20) +
  labs(x = "year", size=20) + 
  labs(title = "Ship encounters with sea ice in the 'high seas'") +
  theme(axis.text.x = element_text(face="bold", color="black", 
                                   size=12, angle=0), 
        axis.text.y = element_text(face="bold", color="black", 
                                   size=18, angle=90),
        text = element_text(size = 22),
        aspect.ratio = 4/4,
        legend.key.size = unit(2, "cm"))
dev.off()

# #create a hexbin plot showing lat vs year and count
# png('ShipIce_Year_hexBin.png', width = 850, height = 600)
# ggplot(mydata, aes(x=year_field, y=y), xaxt = "n", fun = "quantile") + 
#   geom_hex(binwidth = c(1,3)) +
#   labs(y = "lat", size=18) +
#   labs(x = "year", size=18) + 
#   labs(title = "Ship/Ice Interactions by Latitude and Year") +
#   theme(axis.text.x = element_text(face="bold", color="black", 
#                                    size=18, angle=0),
#         axis.text.y = element_text(face="bold", color="black", 
#                                    size=18, angle=90),
#         text = element_text(size = 22),
#         aspect.ratio = 3.5/4)
# dev.off()
