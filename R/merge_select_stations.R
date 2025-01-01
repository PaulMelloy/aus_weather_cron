# Uncompress select stations and merge the data into one file for downstream
#  Processing
# This is a sub-script of run_daily_script.R and assumes the following are in the
#  global environment
#   - dlpath
#   - dltime
#   - weather_path
#   - merge_weather or library(epiphytoolR)

# North Tamborine: IDQ60910.99123.axf
merge_axf_weather(File_compressed = paste0(dl_path,dl_time,"_IDQ60910.tgz"),
                  File_axf = "IDQ60910.99123.axf",
                  File_formatted = "23-24_NTamborine.csv",
                  base_dir = weather_path
)

# Gatton IDQ60910.94562.axf
merge_axf_weather(File_compressed = paste0(dl_path,dl_time,"_IDQ60910.tgz"),
                  File_axf = "IDQ60910.94562.axf",
                  File_formatted = "23-24_Gatton_weather_obs.csv",
                  base_dir = weather_path
)

# Create weather for Applethorpe
merge_axf_weather(File_compressed = paste0(dl_path,dl_time,"_IDQ60910.tgz"),
                  File_axf = "IDQ60910.94553.axf",
                  File_formatted = "23-24_Applethorpe.csv",
                  base_dir = weather_path
)

# Update weather for Mildura Airport
merge_axf_weather(File_compressed = paste0(dl_path,dl_time,"_IDV60910.tgz"),
                  File_axf = "IDV60910.94693.axf",
                  File_formatted = "23-24_MilduraAP.csv",
                  base_dir = weather_path
)

# Update weather for Walpeup Research station.csv
merge_axf_weather(File_compressed = paste0(dl_path,dl_time,"_IDV60910.tgz"),
                  File_axf = "IDV60910.95831.axf",
                  File_formatted = "23-24_WalpeupResearch.csv",
                  base_dir = weather_path
)

# Update weather for Renmark  station.csv
merge_axf_weather(File_compressed = paste0(dl_path,dl_time,"_IDS60910.tgz"),
                  File_axf = "IDS60910.95687.axf",
                  File_formatted = "23-24_RenmarkAP.csv",
                  base_dir = weather_path
)

# Update weather for loxton station.csv
merge_axf_weather(File_compressed = paste0(dl_path,dl_time,"_IDS60910.tgz"),
                  File_axf = "IDS60910.94682.axf",
                  File_formatted = "23-24_LoxtonResearch.csv",
                  base_dir = weather_path
)
