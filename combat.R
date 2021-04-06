# Script to run ComBat Harmonization on T1 Data for McDonald Lab

# Read in the transposed MRI_all.csv and MRI_info.csv files

data_matrix <- read.csv("/Users/dasay/Dropbox/McDonald_Lab/Data/Output_Spreadsheets/MRI_all_transposed_4.6.2021.csv")

data_info <- read.csv("/Users/dasay/Dropbox/McDonald_Lab/Data/Output_Spreadsheets/MRI_info_3.30.2021.csv")

View(data_matrix)
View(data_info)

## Merge Scanner manufacturer with scanner name


toString(data_info$Manufacturer)

toString(data_info$ManufacturersModelName)

scanner <- paste(data_info$Manufacturer, data_info$ManufacturersModelName)

View(scanner)

### Rename the data_matrix and scanner objects to dat and batch, respectively for neuroCombat use.

