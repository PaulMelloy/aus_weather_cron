# setup environment
library(here)
source(here("R/setup.R"),
       echo = TRUE,
       print.eval = TRUE)

return_verbose = TRUE

# ----------------------------
# Run Historically
# ----------------------------
# # find files with desired weather files

# -----------------
# South Australia
# -----------------
zipfiles <- list.files(dl_path,pattern = "_IDS60910.tgz",full.names = TRUE)

for(i in zipfiles){
   # Create weather for Applethorpe
   #  Loxton Research station
   merge_weather(File_compressed = i,
                 station_file = "IDS60910.94682.json",
                 File_formatted = "23-24_LoxtonResearch.csv",
                 base_dir = weather_path,
                 verbose = return_verbose
   )
  
  # Update weather for Renmark  station.csv
  merge_weather(File_compressed = i,
                station_file = "IDS60910.95687.json",
                File_formatted = "23-24_RenmarkAP.csv",
                base_dir = weather_path,
                verbose = return_verbose
  )
  
}

# -----------------
# Queensland
# -----------------
zipfiles <- list.files(dl_path,pattern = "_IDQ60910.tgz",full.names = TRUE)

for(i in zipfiles){
  # North Tamborine: IDQ60910.99123.json
  merge_weather(File_compressed = i,
                    station_file = "IDQ60910.99123.json",
                    File_formatted = "23-24_NTamborine.csv",
                    base_dir = weather_path,
                verbose = return_verbose
  )
  
  # Gatton IDQ60910.94562.json
  merge_weather(File_compressed = i,
                    station_file = "IDQ60910.94562.json",
                    File_formatted = "23-24_Gatton_weather_obs.csv",
                    base_dir = weather_path,
                verbose = return_verbose
  )
  
  # Create weather for Applethorpe
  merge_weather(File_compressed = i,
                    station_file = "IDQ60910.94553.json",
                    File_formatted = "23-24_Applethorpe.csv",
                    base_dir = weather_path,
                verbose = return_verbose
  )
}

# -----------------
# Victoria
# -----------------

zipfiles <- list.files(dl_path,pattern = "_IDV60910.tgz",full.names = TRUE)

for(i in zipfiles){
  # Update weather for Mildura Airport
  merge_weather(File_compressed = i,
                    station_file = "IDV60910.94693.json",
                    File_formatted = "23-24_MilduraAP.csv",
                    base_dir = weather_path,
                verbose = return_verbose
  )
  
  # Update weather for Walpeup Research station.csv
  merge_weather(File_compressed = i,
                    station_file = "IDV60910.95831.json",
                    File_formatted = "23-24_WalpeupResearch.csv",
                    base_dir = weather_path,
                verbose = return_verbose
  )
  
 }
  

# -----------------
# Western Australia
# -----------------
# Update weather for Witchcliffe station.csv
# errors because some weather data files are empty


zipfiles <- list.files(dl_path,pattern = "_IDW60910.tgz",full.names = TRUE)

for(i in zipfiles){
  # Update weather for Mildura Airport
  merge_weather(File_compressed = i,
                station_file = "IDW60910.95641.json",
                File_formatted = "23-24_WitchcliffeWest.csv",
                base_dir = weather_path,
                verbose = return_verbose
  )
  
}
