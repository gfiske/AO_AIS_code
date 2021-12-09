

# Library
library(streamgraph)

#real code
rm(list = ls())
setwd("C:/Data/Arctic/ArcticOptions/tables")

#read in data
myData = read.csv("C:/Data/Arctic/ArcticOptions/tables/streamgraphComponents.csv", header=T, sep=",")
myDate <- as.Date(myData$date, origin = "2009-09-01")
data=data.frame(myDate, myData$EEZ, myData$count)
#make streamgraph
##streamgraph(data, key="myData.EEZ", value="myData.count", date="myDate", offset="zero")
streamgraph(data, key="myData.EEZ", value="myData.count", date="myDate", offset = 1000000)

#or differently
streamgraph(data, "myData.EEZ", "myData.count", "myDate", offset = "zero", interactive = TRUE) %>%
  sg_axis_x(1, "year", "%Y") %>%
  sg_fill_brewer("PuOr")
#color palettes here: https://moderndata.plot.ly/create-colorful-graphs-in-r-with-rcolorbrewer-and-plotly/

#try to export as a png
library(webshot)
#install phantom
##webshot::install_phantomjs()
webshot("C:/Data/Arctic/ArcticOptions/tables/testpage.html" , "output.png", delay = 0.2 , cliprect = c(440, 0, 1000, 10))

##THIS DIDN'T WORK
#Instead I used SVG Crowbar Chrome add-on built by the NYTimes graphics folks