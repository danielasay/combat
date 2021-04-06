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

scanner <- as.data.frame(scanner)

library(dplyr)

scanner %>%
  mutate(Scanner_Number = case_when(
    endsWith(scanner, "m") ~ "1",
    endsWith(scanner, "z") ~ "2",
    TRUE ~ as.character(Scanner_Number)
  ))

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

as.numeric(data_matrix)

View(scanner)

### Run neuroCombat

data.harmonized <- neuroCombat(dat = data_matrix, batch = scanner$scanner_number)












