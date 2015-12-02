#dwoload files
download.file("http://data.london.gov.uk/api/rest/dump/catalogue.xlsx", 
              "./LondonDataStore/catalogue.xlsx", method = "curl")
download.file("https://files.datapress.com/london/dataset/ward-profiles-and-atlas/2015-09-24T14:21:52/ward-atlas-data.csv",
              "./LondonDataStore/ward-atlas-data-original.csv", method = "curl")
#read the csv excluding line 2
all_content = readLines("./LondonDataStore/ward-atlas-data-original.csv")
skip_second = all_content[-2]
WardAtlas = read.csv(textConnection(skip_second), header = TRUE, stringsAsFactors = FALSE)
rm(all_content, skip_second)
#rename columns
names(WardAtlas) <- gsub(".", "_", names(WardAtlas), fixed = TRUE);
names(WardAtlas) <- gsub("__", "_", names(WardAtlas), fixed = TRUE); 
names(WardAtlas) <- gsub("__", "_", names(WardAtlas), fixed = TRUE);
names(WardAtlas) <- gsub("__", "_", names(WardAtlas), fixed = TRUE)
head(WardAtlas)
str(WardAtlas)
#Save and open
write.table(WardAtlas, "./LondonDataStore/ward-atlas-data.csv", sep = ",")
WardAtlas <- read.csv("./LondonDataStore/ward-atlas-data.csv")
