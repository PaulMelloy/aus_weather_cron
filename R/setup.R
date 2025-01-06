if("remotes" %in% installed.packages()[,"Package"] == FALSE){
  install.packages("remotes")
}
if("data.table" %in% installed.packages()[,"Package"] == FALSE){
  install.packages("data.table")
}
if("epiphytoolR" %in% installed.packages()[,"Package"] == FALSE){
  remotes::install_github("PaulMelloy/epiphytoolR", ref = "dev")
}

working_dir <- path.expand("~") # default to users home directory

library(data.table)
library(epiphytoolR)

## -----------------        Settings        -----------------
SLEEP <- TRUE
dl_path <- file.path(working_dir,"weather_data/tgz/")
dl_time <- format(Sys.time(), format = "%y%m%d_%H%M")
weather_path <- file.path(working_dir,"weather_data/")


## ----------            System checks            -----------
if(dir.exists(dl_path) == FALSE) dir.create(dl_path,recursive = TRUE)
if(dir.exists(weather_path) == FALSE) dir.create(weather_path,recursive = TRUE)
