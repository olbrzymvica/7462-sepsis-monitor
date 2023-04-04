library(tidyverse)
library(data.table) ## For the fread function
library(lubridate)
library(googledrive)

source("sepsis_monitor_functions.R")

#reading file
file_link <- "https://drive.google.com/file/d/1pH0zGLKzuQz9KqixikuPythYqgINWWob/view?usp=sharing"
sepsis <- drive_read_string(file_link) %>%
  read_csv()

#changing the name of the current file as the "sepsis_report.csv" file
drive_put(media = "sepsis_report_up.csv",  
          path = "https://drive.google.com/drive/u/1/folders/1iR5y6jUC2qjC7DTj9mNwMrzUaTOpPjgl",
          name = "sepsis_report.csv")

#updating patients
up_sepsis<-updatePatients(sepsis)
up_sepsis %>% write_csv("sepsis_report_up.csv")

#uploading updated report
drive_put(media = "sepsis_report_up.csv",  
          path = "https://drive.google.com/drive/u/1/folders/1iR5y6jUC2qjC7DTj9mNwMrzUaTOpPjgl",
          name = "sepsis_report_up.csv")
