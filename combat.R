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

scanner <- scanner[-c(135, 136)]

View(scanner)

### Run neuroCombat

data.harmonized <- neuroCombat(dat = dat, batch = batch)












