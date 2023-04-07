library(tidyverse)
library(data.table) ## For the fread function
library(lubridate)
library(ggplot2)
library(googledrive)
library(tictoc)

source("sepsis_monitor_functions.R")

df <- makeSepsisDataset()

# We have to write the file to disk first, then upload it
df %>% write_csv("sepsis_data_temp.csv")


sepsis_file <- drive_put(media = "sepsis_data_temp.csv", 
                         path = "https://drive.google.com/drive/u/1/folders/1iR5y6jUC2qjC7DTj9mNwMrzUaTOpPjgl",
                         name = "sepsis_data.csv")

# Set the file permissions so anyone can download this file.
sepsis_file %>% drive_share_anyone()

file_link<-"https://drive.google.com/file/d/1Rt8moMSEKvlsGTD8CM63mcFLpFR3o9TL/view?usp=share_link"
new_data <- updateData(file_link)
most_recent_data <- new_data %>%
  group_by(PatientID) %>%
  filter(obsTime == max(obsTime))

#FREAD:

tic()
makeSepsisDataset()
toc()
#5.67s elapsed

tic()
makeSepsisDataset(n=100)
toc()
#10.39s elapsed

tic()
makeSepsisDataset(n=500)
toc()
#54.59s elapsed

#read_delim:

tic()
makeSepsisDataset(read_fn="read_delim")
toc()
#24.26s elapsed

tic()
makeSepsisDataset(n=100, read_fn="read_delim")
toc()
#50.47s elapsed

tic()
makeSepsisDataset(n=500, read_fn="read_delim")
toc()
#249.33s elapsed