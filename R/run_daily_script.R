library(data.table)
library(epiphytoolR)
#source("/homevol/pmelloy/R/BarleyNetBlotchMeta/R/merge_axf_weather.R")
SLEEP <- FALSE
dl_time <- format(Sys.time(), format = "%y%m%d_%H%M")

if(SLEEP) {
  Sys.sleep(round(runif(1, 0, 240))) # wait randomly between 0 amd 4 minutes
}
get_bom_observations(ftp_url = "ftp://ftp.bom.gov.au/anon/gen/fwo/",
                     download_location = "/homevol/pmelloy/Weather observations/tgz/",
                     access_warning = FALSE,
                     state = "QLD",
                     file_prefix = dl_time
)

if(SLEEP) {
  Sys.sleep(round(runif(1, 0, 240))) # wait randomly between 0 amd 4 minutes
}

get_bom_observations(ftp_url = "ftp://ftp.bom.gov.au/anon/gen/fwo/",
                     download_location = "/homevol/pmelloy/Weather observations/tgz/",
                     access_warning = FALSE,
                     state = "NSW",
                     file_prefix = dl_time
)
if(SLEEP) {
  Sys.sleep(round(runif(1, 0, 240))) # wait randomly between 0 amd 4 minutes
}
get_bom_observations(ftp_url = "ftp://ftp.bom.gov.au/anon/gen/fwo/",
                     download_location = "/homevol/pmelloy/Weather observations/tgz/",
                     access_warning = FALSE,
                     file_prefix = dl_time,
                     state = "NT"
)
if(SLEEP) {
  Sys.sleep(round(runif(1, 0, 240))) # wait randomly between 0 amd 4 minutes
}
get_bom_observations(ftp_url = "ftp://ftp.bom.gov.au/anon/gen/fwo/",
                     download_location = "/homevol/pmelloy/Weather observations/tgz/",
                     access_warning = FALSE,
                     state = "SA",
                     file_prefix = dl_time
)
if(SLEEP) {
  Sys.sleep(round(runif(1, 0, 240))) # wait randomly between 0 amd 4 minutes
}
get_bom_observations(ftp_url = "ftp://ftp.bom.gov.au/anon/gen/fwo/",
                     download_location = "/homevol/pmelloy/Weather observations/tgz/",
                     access_warning = FALSE,
                     file_prefix = dl_time,
                     state = "VIC"
)
if(SLEEP) {
  Sys.sleep(round(runif(1, 0, 240))) # wait randomly between 0 amd 4 minutes
}
get_bom_observations(ftp_url = "ftp://ftp.bom.gov.au/anon/gen/fwo/",
                     download_location = "/homevol/pmelloy/Weather observations/tgz/",
                     access_warning = FALSE,
                     file_prefix = dl_time,
                     state = "WA"
)
if(SLEEP) {
  Sys.sleep(round(runif(1, 0, 240))) # wait randomly between 0 amd 4 minutes
}
get_bom_observations(ftp_url = "ftp://ftp.bom.gov.au/anon/gen/fwo/",
                     download_location = "/homevol/pmelloy/Weather observations/tgz/",
                     access_warning = FALSE,
                     state = "TAS",
                     file_prefix = dl_time
)


# North Tamborine: IDQ60910.99123.axf
merge_axf_weather(File_compressed = paste0("/homevol/pmelloy/Weather observations/tgz/",dl_time,"_IDQ60910.tgz"),
                  File_axf = "IDQ60910.99123.axf",
                  File_formatted = "23-24_NTamborine.csv",
                  base_dir = "/homevol/pmelloy/Weather observations/"
)

# Gatton IDQ60910.94562.axf
merge_axf_weather(File_compressed = paste0("/homevol/pmelloy/Weather observations/tgz/",dl_time,"_IDQ60910.tgz"),
                  File_axf = "IDQ60910.94562.axf",
                  File_formatted = "23-24_Gatton_weather_obs.csv",
                  base_dir = "/homevol/pmelloy/Weather observations/"
)

# Create weather for Applethorpe
merge_axf_weather(File_compressed = paste0("/homevol/pmelloy/Weather observations/tgz/",dl_time,"_IDQ60910.tgz"),
                  File_axf = "IDQ60910.94553.axf",
                  File_formatted = "23-24_Applethorpe.csv",
                  base_dir = "/homevol/pmelloy/Weather observations/"
)

# Update weather for Mildura Airport
merge_axf_weather(File_compressed = paste0("/homevol/pmelloy/Weather observations/tgz/",dl_time,"_IDV60910.tgz"),
                  File_axf = "IDV60910.94693.axf",
                  File_formatted = "23-24_MilduraAP.csv",
                  base_dir = "/homevol/pmelloy/Weather observations/"
)

# Update weather for Walpeup Research station.csv
merge_axf_weather(File_compressed = paste0("/homevol/pmelloy/Weather observations/tgz/",dl_time,"_IDV60910.tgz"),
                  File_axf = "IDV60910.95831.axf",
                  File_formatted = "23-24_WalpeupResearch.csv",
                  base_dir = "/homevol/pmelloy/Weather observations/"
)

# Update weather for Renmark  station.csv
merge_axf_weather(File_compressed = paste0("/homevol/pmelloy/Weather observations/tgz/",dl_time,"_IDS60910.tgz"),
                  File_axf = "IDS60910.95687.axf",
                  File_formatted = "23-24_RenmarkAP.csv",
                  base_dir = "/homevol/pmelloy/Weather observations/"
)

# Update weather for loxton station.csv
merge_axf_weather(File_compressed = paste0("/homevol/pmelloy/Weather observations/tgz/",dl_time,"_IDS60910.tgz"),
                  File_axf = "IDS60910.94682.axf",
                  File_formatted = "23-24_LoxtonResearch.csv",
                  base_dir = "/homevol/pmelloy/Weather observations/"
)

# Update weather for Witchcliffe station.csv
# errors because some weather data files are empty
# merge_axf_weather(File_compressed = paste0("/homevol/pmelloy/Weather observations/tgz/240101_1500_IDW60910.tgz"),
#                   File_axf = "IDW60910.95641.axf",
#                   File_formatted = "23-24_WitchcliffeWest.csv",
#                   base_dir = "/homevol/pmelloy/Weather observations/"
# )

#source("~/R/preformat_Ntamborine_data.R")

# ----------------------------
# Run Historically
# ----------------------------
# # find files with desired weather files
zipfiles <- list.files("/homevol/pmelloy/Weather observations/tgz/",pattern = "_IDS60910.tgz")

for(i in zipfiles){
   # Create weather for Applethorpe
   #  Stanthorpe only records 3 hourly
   merge_axf_weather(File_compressed = paste0("/homevol/pmelloy/Weather observations/tgz/",i),
                     File_axf = "IDS60910.94682.axf",
                     File_formatted = "23-24_LoxtonResearch.csv",
                     base_dir = "/homevol/pmelloy/Weather observations/",
                     verbose = TRUE
   )

 }
#    merge_axf_weather(File_compressed = "/homevol/pmelloy/Weather observations/tgz/230825_1513_IDW60910.tgz",
#                      File_axf = "IDW60910.95641.axf",
#                      File_formatted = "23-24_error5.csv",
#                      base_dir = "/homevol/pmelloy/Weather observations/",
#                      verbose = TRUE
#    )
