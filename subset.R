#Take a subset of the data to figure out what errors are occurring

subset <- read.csv("/Users/dasay/Dropbox/McDonald_Lab/Data/Output_Spreadsheets/subset.csv")

# make the first column the row names

data_subset <- subset[,-1]
rownames(data_subset) <- subset[,1]

# load in info subset and then compare dimensions

info_subset <- read.csv("/Users/dasay/Dropbox/McDonald_Lab/Data/Output_Spreadsheets/info_subset.csv")

as.character(info_subset$V1)

dim(data_subset)

dim(info_subset)

# Take a look at the data

View(data_subset)

View(info_subset)

#run ComBat

data_subset <- as.matrix(data_subset)

info_subset <- as.matrix(info_subset)

data.harmonized <- neuroCombat(dat = data_subset, batch = info_subset)

## Write out csv spreadsheets to send to Erik

write.csv(data_subset, "~/Desktop/data_subset.csv", row.names = TRUE)

write.csv(info_subset, "~/Desktop/scannerinfo_subset.csv", row.names = FALSE)

write.csv(combatExampleData, "~/Desktop/combat_example_data.csv")

write.csv(combatExampleScanner, "~/Desktop/combat_example_scanner.csv", row.names = FALSE)