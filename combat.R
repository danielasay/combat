# Script to run ComBat Harmonization on T1 Data for McDonald Lab
# To run, you will need to install the following packages: devtools neuroCombat

#install.packages("devtools")
#library(devtools)
#install_github("jfortin1/CombatHarmonization/R/neuroCombat")
library(neuroCombat)

# Read in the transposed MRI_all.csv and MRI_info.csv files

data_matrix <- read.csv("/Users/dasay/Dropbox/McDonald_Lab/Data/Output_Spreadsheets/MRI_all_transposed_4.6.2021.csv")

data_info <- read.csv("/Users/dasay/Dropbox/McDonald_Lab/Data/Output_Spreadsheets/matched_scanner_info.csv")

View(data_matrix)
View(data_info)

## Merge Scanner manufacturer with scanner name

scanner <- paste(data_info$Manufacturer, data_info$ManufacturersModelName)

# Turn into Data Frame

scanner <- as.data.frame(scanner)

# Give each Scanner name a specific number

library(dplyr)
scanner <- scanner%>%
  mutate(scanner_number = case_when(
    scanner == "SIEMENS TrioTim" ~ "1",
    scanner == "SIEMENS Prisma_fit" ~ "2",
    scanner == "GE MEDICAL SYSTEMS Signa HDxt" ~ "3",
    scanner == "GE MEDICAL SYSTEMS DISCOVERY MR750" ~ "4",
    scanner == "GE MEDICAL SYSTEMS SIGNA EXCITE" ~ "5",
    scanner == "GE MEDICAL SYSTEMS SIGNA HDx" ~ "6",
    scanner == "GE MEDICAL SYSTEMS SIGNA HDx" ~ "6",
    ))

# Convert scanner_number into a numeric variable

scanner$scanner_number <- as.numeric(scanner$scanner_number)

View(scanner)

# Make the first column of data_matrix into the row names

matrix <- data_matrix[,-1]
rownames(matrix) <- data_matrix[,1]


matrix <- as.data.frame(matrix)

View(matrix)

## Remove rows with missing data and duplicates

dim(matrix)

matrix <- matrix[!apply(matrix == "NaN", 1, all), ]

matrix <- matrix[!apply(matrix == "0", 1, all), ]

matrix <- matrix %>% distinct()

matrix <- distinct(matrix)

### Trim down info and turn it into matrix

scan_num <- scanner$scanner_number

scan_num <- as.matrix(scan_num)
 
## Verify that the data sets are the same size. (The second number from the dim() command should match the number from the length() command)

dim(matrix)
length(scan_num)

### Run neuroCombat

data.harmonized <- neuroCombat(dat = matrix, batch = scan_num)

## Write out data sets to send to Jean-Philippe

write.csv(matrix, "~/Desktop/matrix.csv", row.names = TRUE)
write.csv(scan_num, "~/Desktop/scan_num.csv", row.names = FALSE)

#Take a subset of the data to figure out what errors are ocurring

subset <- read.csv("/Users/dasay/Dropbox/McDonald_Lab/Data/Output_Spreadsheets/subset.csv")

# make the first column the row names

data_subset <- subset[,-1]
rownames(data_subset) <- subset[,1]

# load in info subset and then compare dimensions

info_subset <- read.csv("/Users/dasay/Dropbox/McDonald_Lab/Data/Output_Spreadsheets/info_subset.csv")

dim(data_subset)

dim(info_subset)

#run ComBat

data.harmonized <- neuroCombat(dat = data_subset, batch = info)




