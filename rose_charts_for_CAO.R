#rose_charts_for_CAO.R
#create ggplot rose charts for those ships that cross the boundary of the CAO
#uses the SpaceQuest AIS data 2009-16
#gfiske Apr 7, 2020


rm(list = ls())
require(ggplot2)


#Group by ship size
data_by_size = read.csv("C://Data/Arctic/ArcticOptions/tables/rose_charts_by_size.csv")
maxTonnage = factor(data_by_size$Tonnage)
ggplot(data=data_by_size,aes(x=variable,y=value,fill=maxTonnage))+
  geom_bar(stat="identity")+
  coord_polar(theta = "x", start = 0, direction = 1, clip = "on")+
  scale_x_discrete(limits=c("0","30W","60W","90W","120W","150W","180EW","150E","120E","90E","60E","30E"))+
  scale_fill_brewer(palette="Greens")+xlab("")+ylab("Unique number of ships")+
  theme(text = element_text(size=12),
        axis.text.x = element_text(hjust=1))
ggsave("C://Data/Arctic/ArcticOptions/tables/rose_charts_by_size.jpg")


#Group by ship country
data_by_country = read.csv("C://Data/Arctic/ArcticOptions/tables/rose_charts_by_country.csv")
ggplot(data=data_by_country,aes(x=variable,y=value,fill=Country))+
  geom_bar(stat="identity")+
  coord_polar(theta = "x", start = 0, direction = 1, clip = "on")+
  scale_x_discrete(limits=c("0","30W","60W","90W","120W","150W","180EW","150E","120E","90E","60E","30E"))+
  scale_fill_manual(values=c('#FFFF73','#F573BC','#B4D79E','#AAFF00','#FFA77F','#000000','#E69AA9','#E69800','#E60000','#267300','#8E5FEC','#898944', '#004DA8'))+xlab("")+ylab("Unique number of ships")+
  theme(text = element_text(size=12),
        axis.text.x = element_text(hjust=1))
ggsave("C://Data/Arctic/ArcticOptions/tables/rose_charts_by_country.jpg")


#Group by ship type
data_by_type = read.csv("C://Data/Arctic/ArcticOptions/tables/rose_charts_by_type.csv")
ggplot(data=data_by_type,aes(x=variable,y=value,fill=Type))+
  geom_bar(stat="identity")+
  coord_polar(theta = "x", start = 0, direction = 1, clip = "on")+
  scale_x_discrete(limits=c("0","30W","60W","90W","120W","150W","180EW","150E","120E","90E","60E","30E"))+
  scale_fill_manual(values=c('#a6cee3','#1f78b4','#b2df8a','#33a02c','#fb9a99','#e31a1c','#ff3333','#000000','#cab2d6','#6a3d9a','#ffff99','#b15928', '#f573bc', '#660033', '#ffff00'))+xlab("")+ylab("Unique number of ships")+
  theme(text = element_text(size=12),
        axis.text.x = element_text(hjust=1))
ggsave("C://Data/Arctic/ArcticOptions/tables/rose_charts_by_type.jpg")


