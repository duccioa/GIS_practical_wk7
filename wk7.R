library(maptools)
library(rgdal)
library(rgeos)
library(ggmap)
library(sp)
library(plyr)
library(ggplot2)
library(reshape2)
#Load data
wards <- readOGR("./LondonWards", "London_Ward_CityMerged")
LondonData <- read.csv("./LondonData.csv", sep = ";", stringsAsFactors = FALSE)
LondonData <- LondonData[1:625, ]
LondonData_fixed <- read.csv("./LondonAdditionalDataFixed.csv", sep = ";", stringsAsFactors = FALSE)
#names(LondonData)[3] <- "Wardcode"
#LD_names <- data.frame(names(LondonData))
#LDF_names <- names(LondonData_fixed)
df <- merge(LondonData, LondonData_fixed, by = "Wardcode")
df[,33] <- as.numeric(df[,33])
df_names <- data.frame(names(df))
#rm(LD_names, LDF_names, LondonData, LondonData_fixed)
#hist_MedHHincom_bin3000
##Analyse the variable "MedHHIncom" 
g <- ggplot(df, aes(x = MedHHIncom))
g <- g + geom_histogram(colour = "black", fill = "goldenrod1", binwidth = 3000)
g
g <- ggplot(df, aes(x = MedHHIncom))
g <- g + geom_histogram(colour = "black", fill = "goldenrod1", binwidth = 2000)
g
summ_df <- summary(as.numeric(df[,33]))
g <- ggplot(df, aes(x = MedHHIncom))
g <- g + geom_histogram(colour = "black", fill = "goldenrod1", binwidth = 2000)
g <- g + geom_vline(xintercept = summ_df[4], colour = "red")
g <- g + geom_vline(xintercept = summ_df[3], colour = "blue")
g

g <- ggplot(df, aes(x = MedHHIncom, y = ..density..))
g <- g + geom_histogram(colour = "black", fill = "goldenrod1", binwidth = 2000)
g <- g + geom_vline(xintercept = summ_df[4], colour = "red")
g <- g + geom_vline(xintercept = summ_df[3], colour = "blue")
g <- g + geom_density(colour = "red", size = 1, adjust = 5)
g
##Transform all the variable in numeric
df2 <- LondonData[,4:71]
for(i in 1:68){
    if(is.numeric(df2[,i])){
    df2[,i] <- as.numeric(df2[,i])
    print(class(df2[,i]))
    }
}
##Plot a facet
df2.m <- melt(df2, id = 1:3)
attach(df2.m)
hist <- ggplot(df2.m, aes(x = value))
hist <- hist + geom_histogram(aes(y = ..density..))
hist <- hist + geom_density(colour="red", size=1, adjust=1)
hist + facet_wrap(~ variable, scales="free")
detach(df2.m)
##Plot a facet of the log
attach(df2.m)
hist <- ggplot(df2.m, aes(x = value))
hist <- hist + geom_histogram(aes(y = ..density..))
hist <- hist + geom_density(colour="red", size=1, adjust=1)
hist <- hist + facet_wrap(~ variable, scales="free")
hist
detach(df2.m)


