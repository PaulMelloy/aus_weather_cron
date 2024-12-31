if("remotes" %in% installed.packages()[,"Package"] == FALSE){
  install.packages("remotes")
}
if("data.table" %in% installed.packages()[,"Package"] == FALSE){
  install.packages("data.table")
}
if("epiphytoolR" %in% installed.packages()[,"Package"] == FALSE){
   remotes::install_github("PaulMelloy/epiphytoolR", ref = "dev",
                           lib = "/home/shared/R/lib")
}

working_dir <- path.expand("~") # default to users home directory

library(data.table)
library(epiphytoolR)
#source(paste0(working_dir,"aus_weather_cron/R/get_bom_observations.R"))

## -----------------        Settings        -----------------
SLEEP <- TRUE
dl_path <- paste0(working_dir,"weather_data/tgz/")
dl_time <- format(Sys.time(), format = "%y%m%d_%H%M")
weather_path <- paste0(working_dir,"weather_data")


## ----------            System checks            -----------
if(dir.exists(dl_path) == FALSE) dir.create(dl_path,recursive = TRUE)
if(dir.exists(weather_path) == FALSE) dir.create(weather_path,recursive = TRUE)


## ----------        Download weather data        -----------

aus_states <- c("QLD", "NSW", "NT", "TAS","WA", "VIC", "SA")
lapply(aus_states,function(STATE){
  if(SLEEP) {
    Sys.sleep(round(runif(1, 0, 240))) # wait randomly between 0 and 4 minutes
  }
  get_bom_observations(ftp_url = "ftp://ftp.bom.gov.au/anon/gen/fwo/",
                       download_location = dl_path,
                       access_warning = FALSE,
                       state = STATE,
                       file_prefix = dl_time
  )
})


# Uncompress select stations and merge the data into one file for downstream
#  Processing

# North Tamborine: IDQ60910.99123.json
merge_weather(File_compressed = paste0(dl_path,dl_time,"_IDQ60910.tgz"),
              station_file = "IDQ60910.99123.json",
              File_formatted = "23-24_NTamborine.csv",
              base_dir = weather_path
)

# Gatton IDQ60910.94562.json
merge_weather(File_compressed = paste0(dl_path,dl_time,"_IDQ60910.tgz"),
              station_file = "IDQ60910.94562.json",
              File_formatted = "23-24_Gatton_weather_obs.csv",
              base_dir = weather_path
)

# Create weather for Applethorpe
merge_weather(File_compressed = paste0(dl_path,dl_time,"_IDQ60910.tgz"),
              station_file = "IDQ60910.94553.json",
              File_formatted = "23-24_Applethorpe.csv",
              base_dir = weather_path
)

# Update weather for Mildura Airport
merge_weather(File_compressed = paste0(dl_path,dl_time,"_IDV60910.tgz"),
              station_file = "IDV60910.94693.json",
              File_formatted = "23-24_MilduraAP.csv",
              base_dir = weather_path
)

# Update weather for Walpeup Research station.csv
merge_weather(File_compressed = paste0(dl_path,dl_time,"_IDV60910.tgz"),
              station_file = "IDV60910.95831.json",
              File_formatted = "23-24_WalpeupResearch.csv",
              base_dir = weather_path
)

# Update weather for Renmark  station.csv
merge_weather(File_compressed = paste0(dl_path,dl_time,"_IDS60910.tgz"),
              station_file = "IDS60910.95687.json",
              File_formatted = "23-24_RenmarkAP.csv",
              base_dir = weather_path
)

# Update weather for loxton station.csv
merge_weather(File_compressed = paste0(dl_path,dl_time,"_IDS60910.tgz"),
              station_file = "IDS60910.94682.json",
              File_formatted = "23-24_LoxtonResearch.csv",
              base_dir = weather_path
)

# Update weather for Witchcliffe station.csv
# errors because some weather data files are empty
merge_weather(File_compressed = paste0("/homevol/pmelloy/Weather observations/tgz/240101_1500_IDW60910.tgz"),
                  station_file = "IDW60910.95641.json",
                  File_formatted = "23-24_WitchcliffeWest.csv",
                  base_dir = weather_path
)

#source("~/R/preformat_Ntamborine_data.R")

# ----------------------------
# Run Historically
# ----------------------------
# # # find files with desired weather files
# zipfiles <- list.files(dl_path,pattern = "_IDS60910.tgz")
#
# for(i in zipfiles){
#    # Create weather for Applethorpe
#    #  Stanthorpe only records 3 hourly
#    merge_weather(File_compressed = paste0(dl_path,i),
#                 station_file = "IDS60910.94682.json", 
#                   File_formatted = "23-24_LoxtonResearch.csv",
#                   base_dir = weather_path,
#                   verbose = TRUE
#    )
#
#  }
#    merge_weather(File_compressed = "/homevol/pmelloy/Weather observations/tgz/230825_1513_IDW60910.tgz",
#                  station_file = "IDW60910.95641.json",
#                  File_formatted = "23-24_error5.csv",
#                  base_dir = weather_path,
#                  verbose = TRUE
#    )
