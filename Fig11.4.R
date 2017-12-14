#Charting for Figure 11.4 Berkman et al 2018
#gfiske December 2017

rm(list = ls())
setwd("C:/Data/Arctic/ArcticOptions/tables")

#read table
mydata = read.csv("C:/Data/Arctic/ArcticOptions/tables/unique_mmsi_by_date.csv", header=T, sep=",")

#Daily Unique MMSI Chart
#set X and Y limits
my_ylim <- c(0, 2000)
my_xlim <- c(2009, 2016)
Date4 <- as.vector(mydata$date)
#Date6 <- dates(Date4, format = c(dates ="m/d/Y"), out.format = c(dates= "Y"))
Date6 <- dates(Date4)
yearOnly <- format(as.Date(mydata$date, format="%m/%d/%Y"),"%Y")
#plot the burned variables against the unburned variables and send to output postscript file
jpeg('Fig11.4a.jpg', width = 8.5, height = 5, units = 'in', res = 300)
#postscript('Fig11.4a.eps', horizontal = FALSE, onefile = FALSE, paper = "special", height = 5, width = 8.5)
par(mfrow = c(1,1), bg = "white", xpd = NA, cex.lab = 1.2, xpd=FALSE)
plot(Date6, mydata$Arctic, col = "blue", ylim = my_ylim, xlab = "", ylab = "", pch = 19, cex = .2, xaxt = "n")
abline(lm(mydata$Arctic ~ Date6), col="blue", lwd=3)
points(Date6, mydata$Barents.Sea, col = "red", pch = 19, cex = .2)
abline(lm(mydata$Barents.Sea ~ Date6), col="red", lwd=3)
points(Date6, mydata$Bering.Sea, col = "orange", pch = 19, cex = .2)
abline(lm(mydata$Bering.Sea ~ Date6), col="orange", lwd=3)
points(Date6, mydata$Arctic.minus.Barents.and.Bering.Sea, col = "#009900", pch = 19, cex = .2)
abline(lm(mydata$Arctic.minus.Barents.and.Bering.Sea ~ Date6), col="#009900", lwd=3)
#mtext("Unique MMSI by day", side = 3, line = 0, adj = 0, padj = -0.5, cex = 2)
#legend(75, 30, c("BASR", "BESR", "All others"), pch = c(8, 18, 20), col = c("green2", "gray70", "brown"), bty = "o", cex = 1.5, bg = "white")
dev.off()

#Normalized Daily Unique MMSI Chart
jpeg('Fig11.4c.jpg', width = 8.5, height = 5, units = 'in', res = 300)
#postscript('Fig11.4c.eps', horizontal = FALSE, onefile = FALSE, paper = "special", height = 5, width = 8.5)
my_ylim.1 <- c(0, 0.0013470)
par(mfrow = c(1,1), bg = "white", xpd = NA, cex.lab = 1.2, xpd=FALSE)
plot(Date6, mydata$Arctic.1, col = "blue", ylim = my_ylim.1, xlab = "", ylab = "", pch = 19, cex = .2, xaxt = "n")
abline(lm(mydata$Arctic.1 ~ Date6), col="blue", lwd=3)
points(Date6, mydata$Barents.Sea.1, col = "red", pch = 19, cex = .2)
abline(lm(mydata$Barents.Sea.1 ~ Date6), col="red", lwd=3)
points(Date6, mydata$Bering.Sea.1, col = "orange", pch = 19, cex = .2)
abline(lm(mydata$Bering.Sea.1 ~ Date6), col="orange", lwd=3)
points(Date6, mydata$Arctic.minus.Barents.and.Bering.Sea.1, col = "#009900", pch = 19, cex = .2)
abline(lm(mydata$Arctic.minus.Barents.and.Bering.Sea.1 ~ Date6), col="#009900", lwd=3)
dev.off()

#Number of message counts per satellite Chart
myCounts = read.csv("C:/Data/Arctic/ArcticOptions/tables/MonthlyArcticMessageCounts_from_Glenn.csv", header=T, sep=",")
jpeg('Fig11.4b.jpg', width = 8.5, height = 3.5, units = 'in', res = 300)
#postscript('Fig11.4b.eps', horizontal = FALSE, onefile = FALSE, paper = "special", height = 3.5, width = 8.5)
my_ylim.2 <- c(0,477600)
plot(myCounts$AprizeSat.10,type = "l",col = "#996633", ylim = my_ylim.2, xlab = "", ylab = "", xaxt = "n", lwd=3)
lines(myCounts$AprizeSat.8,type = "l", col = "#734d26", lwd=3)
lines(myCounts$AprizeSat.6,type = "l", col = "#606060", lwd=3)
lines(myCounts$AprizeSat.3,type = "l", col = "#A9A9A9", lwd=3)
dev.off()
