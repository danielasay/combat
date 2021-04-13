# Script to run ComBat Harmonization on T1 Data for McDonald Lab without control subjects
# To run, you will need to install the following packages: devtools neuroCombat

#install.packages("devtools")
#library(devtools)
#install_github("jfortin1/CombatHarmonization/R/neuroCombat")
library(neuroCombat)

# Read in the transposed MRI_all.csv and MRI_info.csv files

data_matrix <- read.csv("/Users/dasay/Dropbox/McDonald_Lab/Data/Output_Spreadsheets/MRI_all_transposed_nocontrols_4.13.2021.csv")

data_info <- read.csv("/Users/dasay/Dropbox/McDonald_Lab/Data/Output_Spreadsheets/matched_scanner_info_nocontrols.csv")

View(data_matrix)
View(data_info)

## Merge Scanner manufacturer with scanner name

scanner <- paste(data_info$Manufacturer, data_info$ManufacturersModelName)

# Turn into dataframe

scanner <- as.data.frame(scanner)

# Give each Scanner name a specific number

library(dplyr)
scanner <- scanner%>%
  mutate(scanner_number = case_when(
    scanner == "SIEMENS TrioTim" ~ "Scanner1",
    scanner == "SIEMENS Prisma_fit" ~ "Scanner2",
    scanner == "GE MEDICAL SYSTEMS Signa HDxt" ~ "Scanner3",
    scanner == "GE MEDICAL SYSTEMS DISCOVERY MR750" ~ "Scanner4",
    scanner == "GE MEDICAL SYSTEMS SIGNA EXCITE" ~ "Scanner5",
    scanner == "GE MEDICAL SYSTEMS SIGNA HDx" ~ "Scanner6",
  ))

View(scanner)

# Make the first column of data_matrix into the row names

matrix <- data_matrix[,-1]
rownames(matrix) <- data_matrix[,1]

## Turn the matrix variable into a matrix class. (this makes it work with ComBat)

matrix <- as.matrix(matrix)

View(matrix)

## Remove rows with missing data and duplicates, check dimensions before and after

dim(matrix)

matrix <- matrix[!apply(matrix == "NaN", 1, all), ]

matrix <- matrix[!apply(matrix == "0", 1, all), ]


dim(matrix)
### Trim down info and turn it into matrix

scan_num <- scanner$scanner_number

scan_num <- as.matrix(scan_num)

## Verify that the data sets are the same size. (The second number from the dim() command should match the number from the length() command)

dim(matrix)
length(scan_num)

### Run neuroCombat

data.harmonized <- neuroCombat(dat = matrix, batch = scan_num)