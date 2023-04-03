library(tidyverse)
library(data.table) ## For the fread function
library(lubridate)

source("sepsis_monitor_functions.R")

df <- initializePatients()


library(googledrive)

# We have to write the file to disk first, then upload it
df %>% write_csv("sepsis_report_temp.csv")

# Uploading happens here
drive_put(media = "sepsis_report_temp.csv",  
          path = "https://drive.google.com/drive/u/1/folders/1iR5y6jUC2qjC7DTj9mNwMrzUaTOpPjgl",
          name = "sepsis_report.csv")


file_link <- "https://drive.google.com/file/d/1pH0zGLKzuQz9KqixikuPythYqgINWWob/view?usp=sharing"
sepsis <- drive_read_string(file_link) %>%
  read_csv()

up_sepsis<-updatePatients(sepsis)
up_sepsis %>% write_csv("sepsis_report_up.csv")

drive_put(media = "sepsis_report_up.csv",  
          path = "https://drive.google.com/drive/u/1/folders/1iR5y6jUC2qjC7DTj9mNwMrzUaTOpPjgl",
          name = "sepsis_report.csv")
