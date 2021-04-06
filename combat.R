# Script to run ComBat Harmonization on T1 Data for McDonald Lab
# To run, you will need to install the following packages: devtools neuroCombat

#install.packages("devtools")
#library(devtools)
#install_github("jfortin1/CombatHarmonization/R/neuroCombat")
#library(neuroCombat)

# Read in the transposed MRI_all.csv and MRI_info.csv files

data_matrix <- read.csv("/Users/dasay/Dropbox/McDonald_Lab/Data/Output_Spreadsheets/MRI_all_transposed_4.6.2021.csv")

data_info <- read.csv("/Users/dasay/Dropbox/McDonald_Lab/Data/Output_Spreadsheets/MRI_info_3.30.2021.csv")

View(data_matrix)
View(data_info)

## Merge Scanner manufacturer with scanner name

scanner <- paste(data_info$Manufacturer, data_info$ManufacturersModelName)

# Remove empty values 

scanner <- scanner[-c(135, 136)]

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

View(matrix)

## Remove rows with missing data

matrix <- matrix[!apply(matrix == "NaN", 1, all), ]

### Run neuroCombat

data.harmonized <- neuroCombat(dat = matrix, batch = scanner$scanner_number)














