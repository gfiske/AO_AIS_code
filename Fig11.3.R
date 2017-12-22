#Charting for Figure 11.3 Berkman et al 2018
#gfiske December 2017

rm(list = ls())
setwd("C:/Data/Arctic/ArcticOptions/tables")

#read monthly table
myMonth = read.csv("C:/Data/Arctic/ArcticOptions/tables/NSIDC_monthly_seaIce_extent_formatted.csv", header=T, sep=",")

#Sea Ice Extent by Month
#jpeg('Fig11.3a.jpg', width = 6.5, height = 5, units = 'in', res = 300)
postscript('Fig11.3a.eps', horizontal = FALSE, onefile = FALSE, paper = "special", height = 5, width = 6.5)
my_ylim <- c(3, 16)
par(mar=c(3,5,1,1), mfrow = c(1,1), bg = "white", xpd = NA, cex.lab = 1.2, xpd=FALSE)
plot(myMonth$id, myMonth$value, type="l", lwd=1.5, col = "grey60", xlab = "", ylab = expression(paste("million (", km^2, ")", sep = "")), pch = 19, cex = .2, xaxt = "n")
abline(lm(myMonth$value ~ myMonth$id), col="blue", lwd=3)
x <- c(1980,1985,1990,1995,2000,2005,2010,2015)
axis(1, at=c(13,73,133,193,253,313,373,433), labels=x )
dev.off()

#read monthly table
myYear = read.csv("C:/Data/Arctic/ArcticOptions/tables/NSIDC_yearly_seaIce_extent_formatted.csv", header=T, sep=",")

#Sea Ice Extent by Year
jpeg('Fig11.3b.jpg', width = 6.5, height = 5, units = 'in', res = 300)
postscript('Fig11.3b.eps', horizontal = FALSE, onefile = FALSE, paper = "special", height = 5, width = 6.5)
#my_ylim <- c(10, 13)
my_ylim <- c(4,16)
par(mar=c(3,5,1,1), mfrow = c(1,1), bg = "white", xpd = NA, cex.lab = 1.2, xpd=FALSE)
plot(myYear$id, myYear$value, type="l", lwd=1.5, col = "grey60", xlab = "", ylab = expression(paste("million (", km^2, ")", sep = "")), pch = 19, cex = .2, xaxt = "n")
abline(lm(myYear$value ~ myYear$id), col="blue", lwd=3)
x <- c(1980,1985,1990,1995,2000,2005,2010,2015)
axis(1, at=c(3,8,13,18,23,28,33,38), labels=x )
dev.off()


#ships by Year
#jpeg('Fig11.3c.jpg', width = 6.5, height = 5, units = 'in', res = 300)
postscript('Fig11.3c.eps', horizontal = FALSE, onefile = FALSE, paper = "special", height = 5, width = 6.5)
par(mar=c(3,5,1,1), mfrow = c(1,1), bg = "white", xpd = NA, cex.lab = 1.2, xpd=FALSE)
data <- structure(list("2009"= c(150L, 1882L, 2032L), 
                "2010" = c(334L, 3269L, 3603L),
                "2011" = c(1098L, 3436L, 4534L),
                "2012" = c(1375L, 3650L, 5025L),
                "2013" = c(1608L, 3733L, 5341L),
                "2014" = c(2416L, 4111L, 6527L),
                "2015" = c(3236L, 4211L, 7447L),
                "2016" = c(4001L, 4194L, 8195L)),.Names = c("2009","2010","2011","2012","2013","2014","2015","2016"), class = "data.frame", row.names = c(NA, -3L))
attach(data)
colours <- c("#804000", "#407739", "grey40")
barplot(as.matrix(data), cex.lab = 2, cex.main = 1, beside=TRUE, col=colours)
legend("topleft", c("type B","type A","All Ships"), cex=1, bty="n", fill=colours)
dev.off()


#ships by Year (just two bars)

ships = read.csv("C:/Data/Arctic/ArcticOptions/tables/Yearly_unique_mmsi_by_ship_type.csv", header=T, sep=",")
#jpeg('Fig11.3c.jpg', width = 6.5, height = 5, units = 'in', res = 300)
postscript('Fig11.3c.eps', horizontal = FALSE, onefile = FALSE, paper = "special", height = 5, width = 6.5)
par(mar=c(3,5,1,1), mfrow = c(1,1), bg = "white", xpd = NA, cex.lab = 1.2, xpd=FALSE)
data <- structure(list("2009"= c(1882L, 2032L), 
                       "2010" = c(3269L, 3603L),
                       "2011" = c(3436L, 4534L),
                       "2012" = c(3650L, 5025L),
                       "2013" = c(3733L, 5341L),
                       "2014" = c(4111L, 6527L),
                       "2015" = c(4211L, 7447L),
                       "2016" = c(4194L, 8195L)),.Names = c("2009","2010","2011","2012","2013","2014","2015","2016"), class = "data.frame", row.names = c(NA, -2L))
attach(data)
colours <- c("#407739", "grey40")
barplot(as.matrix(data), cex.lab = 2, cex.main = 1, beside=TRUE, col=colours)
legend("topleft", c("type A","All Ships"), cex=1, bty="n", fill=colours)
fit <- lm(ships$all.ships~ships$year)
abline(fit, lty = 2)
dev.off()

