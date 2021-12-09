
rm(list = ls())
setwd("C:/Data/Arctic/ArcticOptions/tables")

#read table
mydata = read.csv("C:/Data/Arctic/ArcticOptions/tables/unique_mmsi_by_date.csv", header=T, sep=",")

#Daily Unique MMSI Chart
#set X and Y limits
my_ylim <- c(0, 2000)
my_xlim <- c(2009, 2016)
Date4 <- as.vector(mydata$date)
Date6 <- dates(Date4, format = c(dates ="m/d/Y"), out.format = c(dates= "Y"))
Date6 <- dates(Date4)
yearOnly <- format(as.Date(mydata$date, format="%m/%d/%Y"),"%Y")
#plot the burned variables against the unburned variables and send to output postscript file
jpeg('Fig11.4a.jpg', width = 8.5, height = 5, units = 'in', res = 300)
#postscript('Fig11.4a.eps', horizontal = FALSE, onefile = FALSE, paper = "special", height = 5, width = 8.5)
par(mfrow = c(1,1), bg = "white", xpd = NA, cex.lab = 1.2, xpd=FALSE)
plot(Date4, mydata$Arctic, col = "blue", ylim = my_ylim, xlab = "", ylab = "", pch = 19, cex = .2, xaxt = "n")
abline(lm(mydata$Arctic ~ Date4), col="blue", lwd=3)
points(Date4, mydata$Barents.Sea, col = "red", pch = 19, cex = .2)
abline(lm(mydata$Barents.Sea ~ Date4), col="red", lwd=3)
points(Date4, mydata$Bering.Sea, col = "orange", pch = 19, cex = .2)
abline(lm(mydata$Bering.Sea ~ Date6), col="orange", lwd=3)
points(Date4, mydata$Arctic.minus.Barents.and.Bering.Sea, col = "#009900", pch = 19, cex = .2)
abline(lm(mydata$Arctic.minus.Barents.and.Bering.Sea ~ Date4), col="#009900", lwd=3)
#mtext("Unique MMSI by day", side = 3, line = 0, adj = 0, padj = -0.5, cex = 2)
#legend(75, 30, c("BASR", "BESR", "All others"), pch = c(8, 18, 20), col = c("green2", "gray70", "brown"), bty = "o", cex = 1.5, bg = "white")
dev.off()