

# Library
library(streamgraph)

#real code
rm(list = ls())
setwd("C:/Data/Arctic/ArcticOptions/tables")

#read in data
myData = read.csv("C:/Data/Arctic/ArcticOptions/tables/flags_in_highseas2.csv", header=T, sep=",")
#subset just the top countries, in order desc
myData <- subset(myData, country=="Russian Federation"
                 | country=="Canada"
                 | country=="United States of America"
                 | country=="China (People's Republic of)"
                 | country=="Panama (Republic of)"
                 | country=="Alaska (State of)"
                 # | country=="Korea (Republic of)"
                 # | country=="Japan"
                 # | country=="Philippines (Republic of the)"
                 # | country=="Germany (Federal Republic of)"
                 # | country=="Norway"
                 # | country=="Sweden"
                 # | country=="Iceland"
                 # | country=="Singapore (Republic of)"
                 # | country=="Bahamas (Commonwealth of the)"
                 # | country=="Hong Kong (Special Administrative Region of China)"
                 )
myDate <- as.Date(myData$date, origin = "2009-09-01")
data=data.frame(myDate, myData$country, myData$count)

#aggregate to find the flags with highest counts
myAgg <- aggregate(myData$count, by=list(Category=myData$country), FUN=sum)
write.csv(myAgg, file = "C:/Data/Arctic/ArcticOptions/tables/flags_in_highseas_ordered_by_freq.csv")


#make streamgraph
##streamgraph(data, key="myData.EEZ", value="myData.count", date="myDate", offset="zero")
streamgraph(data, key="myData.country", value="myData.count", date="myDate", offset = 30)

#or differently
streamgraph(data, "myData.country", "myData.count", "myDate", offset = "zero", interactive = TRUE) %>%
  sg_axis_x(1, "year", "%Y") %>%
  sg_fill_brewer("Spectral")
#color palettes here: https://moderndata.plot.ly/create-colorful-graphs-in-r-with-rcolorbrewer-and-plotly/
#that site is crap, try this one: https://www.datanovia.com/en/blog/the-a-z-of-rcolorbrewer-palette/


##THE BELOW DIDN'T WORK
#Instead I just exported it from the Viewer and used SVG Crowbar Chrome add-on built by the NYTimes graphics folks

#try to export as a png
library(webshot)
#install phantom
##webshot::install_phantomjs()
webshot("C:/Data/Arctic/ArcticOptions/tables/flags_in_CAO.html" , "output.png", delay = 0.2 , cliprect = c(440, 0, 1000, 10))


