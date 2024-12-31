# setup environment
source("R/setup.R",
       echo = TRUE,
       print.eval = TRUE)

# ----------------------------
# Run Historically
# ----------------------------
# # find files with desired weather files
zipfiles <- list.files(dl_path,pattern = "_IDS60910.tgz")

for(i in zipfiles){
   # Create weather for Applethorpe
   #  Stanthorpe only records 3 hourly
   merge_weather(File_compressed = paste0(dl_path,i),
                station_file = "IDS60910.94682.json",
                  File_formatted = "23-24_LoxtonResearch.csv",
                  base_dir = weather_path,
                  verbose = TRUE
   )

 }
   # merge_weather(File_compressed = "/homevol/pmelloy/Weather observations/tgz/230825_1513_IDW60910.tgz",
   #               station_file = "IDW60910.95641.json",
   #               File_formatted = "23-24_error5.csv",
   #               base_dir = weather_path,
   #               verbose = TRUE
   # )