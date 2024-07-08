## code to prepare `DATASET` dataset goes here
library(data.table)
library(epiphytoolR)
# source("~/R/downy_dst/R/impute_temp.R")
# source("~/R/downy_dst/R/impute_rh.R")

#if(Sys.info()["nodename"] == "rstudio") {
  # update libraries for the shiny server
  #source("~/R/update_libraries.R")
  # read in latest data
  NT_weather <- fread("~/Weather observations/23-24_NTamborine.csv")
  AT_weather <- fread("~/Weather observations/23-24_Applethorpe.csv")
  LX_weather <- fread("~/Weather observations/23-24_LoxtonResearch.csv")
  MI_weather <- fread("~/Weather observations/23-24_MilduraAP.csv")
  WA_weather <- fread("~/Weather observations/23-24_WalpeupResearch.csv")
#} else{
  # read in the raw data
  NT_weather <- data.table::fread(
    system.file("extdata",
                "weather_north_tamborine.csv",
                package = "viticolaR"))
#}


NT_weather[,lon := 153.1914]
NT_weather[,lat := -27.9396]

AT_weather[,lon := 151.95]
AT_weather[,lat := -28.62]

# format times
NT_weather[,aifstime_utc := as.POSIXct(as.character(aifstime_utc),
                                       format = "%Y%m%d%H%M%S",
                                       tz = "UTC")]
AT_weather[,aifstime_utc := as.POSIXct(as.character(aifstime_utc),
                                       format = "%Y%m%d%H%M%S",
                                       tz = "UTC")]
LX_weather[,aifstime_utc := as.POSIXct(as.character(aifstime_utc),
                                       format = "%Y%m%d%H%M%S",
                                       tz = "UTC")]
WA_weather[,aifstime_utc := as.POSIXct(as.character(aifstime_utc),
                                       format = "%Y%m%d%H%M%S",
                                       tz = "UTC")]
MI_weather[,aifstime_utc := as.POSIXct(as.character(aifstime_utc),
                                       format = "%Y%m%d%H%M%S",
                                       tz = "UTC")]



# for information on what the column headers relate to
#  http://www.bom.gov.au/catalogue/Observations-XML.pdf
suppressWarnings(
  NT_weather <-
    epiphytoolR::format_weather(
      NT_weather,
      POSIXct_time = "aifstime_utc",
      time_zone = "UTC",
      temp = "air_temp",
      rain = "rain_ten",
      rh = "rel_hum",
      ws = "wind_spd_kmh",
      wd = "wind_dir_deg",
      station = "name",
      lon = "lon",
      lat = "lat",
      data_check = FALSE))

NT_weather <- impute_temp(NT_weather, rolling_window = 60)
NT_weather <- impute_rh(NT_weather, rolling_window = 60)

suppressWarnings(
  AT_weather <-
    epiphytoolR::format_weather(
      AT_weather,
      POSIXct_time = "aifstime_utc",
      time_zone = "UTC",
      temp = "air_temp",
      rain = "rain_ten",
      rh = "rel_hum",
      ws = "wind_spd_kmh",
      wd = "wind_dir_deg",
      station = "name",
      lon = "lon",
      lat = "lat",
      data_check = FALSE))

AT_weather <- impute_temp(AT_weather, rolling_window = 60)
AT_weather <- impute_rh(AT_weather, rolling_window = 60)

suppressWarnings(
  LX_weather <-
    epiphytoolR::format_weather(
      LX_weather,
      POSIXct_time = "aifstime_utc",
      time_zone = "UTC",
      temp = "air_temp",
      rain = "rain_ten",
      rh = "rel_hum",
      ws = "wind_spd_kmh",
      wd = "wind_dir_deg",
      station = "name",
      lon = "lon",
      lat = "lat",
      data_check = FALSE))

LX_weather <- impute_temp(LX_weather, rolling_window = 60)
LX_weather <- impute_rh(LX_weather, rolling_window = 60)


suppressWarnings(
  WA_weather <-
    epiphytoolR::format_weather(
      WA_weather,
      POSIXct_time = "aifstime_utc",
      time_zone = "UTC",
      temp = "air_temp",
      rain = "rain_ten",
      rh = "rel_hum",
      ws = "wind_spd_kmh",
      wd = "wind_dir_deg",
      station = "name",
      lon = "lon",
      lat = "lat",
      data_check = FALSE))

WA_weather <- impute_temp(WA_weather, rolling_window = 60)
WA_weather <- impute_rh(WA_weather, rolling_window = 60)

# create standard deviation of wind speed
# given the wikipedia description between wind gusts and average wind speed
# we will use 1 sd as half the difference between wind speed and wind gusts
MI_weather[, wsp_sd := (gust_kmh - wind_spd_kmh)/2]
MI_weather[,wdir_sd := 50]

suppressWarnings(
  MI_weather <-
    epiphytoolR::format_weather(
      MI_weather,
      POSIXct_time = "aifstime_utc",
      time_zone = "UTC",
      temp = "air_temp",
      rain = "rain_ten",
      rh = "rel_hum",
      ws = "wind_spd_kmh",
      wd = "wind_dir_deg",
      wd_sd = "wdir_sd",
      station = "name",
      lon = "lon",
      lat = "lat",
      data_check = FALSE))

MI_weather <- impute_temp(MI_weather, rolling_window = 60)
MI_weather <- impute_rh(MI_weather, rolling_window = 60)

#
# # set the width of the rolling window, this will impact the smoothing of the
# #  imputation
# rolling_window <- 60
# # set the index in the table, this is needed for the rolling apply function
# NT_weather[,indx := .I]
# AT_weather[,indx := .I]
# LX_weather[,indx := .I]
# MI_weather[,indx := .I]
# WA_weather[,indx := .I]
#
# ## check how many NAs are in the temperature column
# # NT_weather[is.na(temp),indx]
# # NT_weather[is.na(temp),indx]
# LX_weather[is.na(temp),indx]
# MI_weather[is.na(temp),indx]
# WA_weather[is.na(temp),indx]
#
#
# # Rolling apply using the impute_fill function on temperature variable
# NT_weather[, tm_imp := round(data.table::frollapply(
#   indx,
#   n = rolling_window,
#   fill = NA_real_,
#   FUN = epiphytoolR::impute_fill,
#   FUN_n = rolling_window,
#   times = times,
#   var = temp,
#   align = "center"
# ),3)]
#
# AT_weather[, tm_imp := round(data.table::frollapply(
#    indx,
#    n = rolling_window,
#    fill = NA_real_,
#    FUN = epiphytoolR::impute_fill,
#    FUN_n = rolling_window,
#    times = times,
#    var = temp,
#    align = "center"
# ),3)]
#
# # Rolling apply using the impute_fill function on temperature variable
# MI_weather[, tm_imp := round(data.table::frollapply(
#    indx,
#    n = rolling_window,
#    fill = NA_real_,
#    FUN = epiphytoolR::impute_fill,
#    FUN_n = rolling_window,
#    times = times,
#    var = temp,
#    align = "center"
# ),3)]
#
#
# # # visualise the fit of the fill
# plot(NT_weather$temp[1050:1600], type = "l")
# lines(NT_weather$tm_imp[1050:1600], type = "l", col = "blue")
# abline(v = seq(0,550, by = 24))
#
# plot(AT_weather$temp[1050:1600], type = "l")
# lines(AT_weather$tm_imp[1050:1600], type = "l", col = "blue")
# abline(v = seq(0,550, by = 24))
#
# # set the NAs in temperature with the estimated temperature
# NT_weather[is.na(temp), temp:= tm_imp]
# AT_weather[is.na(temp), temp:= tm_imp]
# MI_weather[is.na(temp), temp:= tm_imp]
#
# # # Check how many NAs remain
# # NT_weather[is.na(temp),indx]
# MI_weather[is.na(temp),indx]
# LX_weather[is.na(temp),indx]
#
# # We could widen the rolling_window, so we only need to impute once or we can
# #  run the function twice.
# # we can run the impute_fill function over the same data to fill in the rest
# dif <- 20
# while(dif > 0) {
#   #get nas
#   na_s <- length(NT_weather[is.na(temp), indx])
#   NT_weather[, tm_imp := round(
#     data.table::frollapply(
#       indx,
#       n = rolling_window,
#       fill = NA_real_,
#       FUN = epiphytoolR::impute_fill,
#       FUN_n = rolling_window,
#       times = times,
#       var = temp,
#       align = "center"
#     ),
#     3
#   )]
#
#   # set the NAs in temperature with the estimated temperature
#   NT_weather[is.na(temp), temp := tm_imp]
#
#
#   # Check how many NAs remain
#   dif <- na_s - length(NT_weather[is.na(temp), indx])
#   # cat("Dif remaining: ", dif,"\n")
# }
#
# dif <- 20
# while(dif > 0) {
#    #get nas
#    na_s <- length(AT_weather[is.na(temp), indx])
#    AT_weather[, tm_imp := round(
#       data.table::frollapply(
#          indx,
#          n = rolling_window,
#          fill = NA_real_,
#          FUN = epiphytoolR::impute_fill,
#          FUN_n = rolling_window,
#          times = times,
#          var = temp,
#          align = "center"
#       ),
#       3
#    )]
#
#    # set the NAs in temperature with the estimated temperature
#    AT_weather[is.na(temp), temp := tm_imp]
#
#
#    # Check how many NAs remain
#    dif <- na_s - length(AT_weather[is.na(temp), indx])
#    # cat("Dif remaining: ", dif,"\n")
# }
#
# # we can run the impute_fill function over the same data to fill in the rest
# dif <- 20
# while(dif > 0) {
#    #get nas
#    na_s <- length(NT_weather[is.na(temp), indx])
#    NT_weather[, tm_imp := round(
#       data.table::frollapply(
#          indx,
#          n = rolling_window,
#          fill = NA_real_,
#          FUN = epiphytoolR::impute_fill,
#          FUN_n = rolling_window,
#          times = times,
#          var = temp,
#          align = "center"
#       ),
#       3
#    )]
#
#    # set the NAs in temperature with the estimated temperature
#    NT_weather[is.na(temp), temp := tm_imp]
#
#
#    # Check how many NAs remain
#    dif <- na_s - length(NT_weather[is.na(temp), indx])
#    # cat("Dif remaining: ", dif,"\n")
# }
#
# # # visualise the fit of the fill
# # plot(NT_weather$temp[2200:2243], type = "l")
# # lines(NT_weather$tm_imp[2200:2243], type = "l", col = "blue")
# # abline(v = seq(0,43, by = 24))
#
#
# # Impute Relative humidity _____________________
# LX_weather[is.na(rh),indx]
# MI_weather[is.na(rh),indx]
# WA_weather[is.na(rh),indx]
#
#
# dif <- length(NT_weather[is.na(rh), indx])
# while(dif > 0) {
#   #get nas
#   na_s <- length(NT_weather[is.na(rh), indx])
#   NT_weather[, rh_imp := round(
#     data.table::frollapply(
#       indx,
#       n = rolling_window,
#       fill = NA_real_,
#       FUN = epiphytoolR::impute_fill,
#       FUN_n = rolling_window,
#       times = times,
#       var = rh,
#       align = "center"
#     ),
#     3
#   )]
#   # set the NAs in temperature with the estimated temperature
#   NT_weather[is.na(rh), rh := rh_imp]
#   # Check how many NAs remain
#   dif <- na_s - length(NT_weather[is.na(rh), indx])
#   ## Report
#   # cat("Dif remaining: ", dif,"\n")
# }
#
# dif <- length(AT_weather[is.na(rh), indx])
# while(dif > 0) {
#    #get nas
#    na_s <- length(AT_weather[is.na(rh), indx])
#    AT_weather[, rh_imp := round(
#       data.table::frollapply(
#          indx,
#          n = rolling_window,
#          fill = NA_real_,
#          FUN = epiphytoolR::impute_fill,
#          FUN_n = rolling_window,
#          times = times,
#          var = rh,
#          align = "center"
#       ),
#       3
#    )]
#    # set the NAs in temperature with the estimated temperature
#    AT_weather[is.na(rh), rh := rh_imp]
#    # Check how many NAs remain
#    dif <- na_s - length(AT_weather[is.na(rh), indx])
#    ## Report
#    # cat("Dif remaining: ", dif,"\n")
# }
#
# dif <- length(MI_weather[is.na(rh), indx])
# while(dif > 0) {
#    #get nas
#    na_s <- length(MI_weather[is.na(rh), indx])
#    MI_weather[, rh_imp := round(
#       data.table::frollapply(
#          indx,
#          n = rolling_window,
#          fill = NA_real_,
#          FUN = epiphytoolR::impute_fill,
#          FUN_n = rolling_window,
#          times = times,
#          var = rh,
#          align = "center"
#       ),
#       3
#    )]
#    # set the NAs in temperature with the estimated temperature
#    MI_weather[is.na(rh), rh := rh_imp]
#    # Check how many NAs remain
#    dif <- na_s - length(MI_weather[is.na(rh), indx])
#    ## Report
#    # cat("Dif remaining: ", dif,"\n")
# }
#


# # check how many NA entries remain and trim them
# NT_weather[, .(temp_nas = sum(is.na(temp)),
#       rh_nas = sum(is.na(rh)))]
# dim(NT_weather)
# Remove lines with NAs
if(nrow(NT_weather[is.na(temp)]) >=1){
  NT_weather <- NT_weather[1:(which(is.na(temp))[1]-1)]}
if(nrow(AT_weather[is.na(temp)]) >=1){
  AT_weather <- AT_weather[1:(which(is.na(temp))[1]-1)]}
if(nrow(LX_weather[is.na(temp)]) >=1){
  LX_weather <- LX_weather[1:(which(is.na(temp))[1]-1)]}
if(nrow(MI_weather[is.na(temp)]) >=1){
  MI_weather <- MI_weather[1:(which(is.na(temp))[1]-1)]}
if(nrow(WA_weather[is.na(temp)]) >=1){
  WA_weather <- WA_weather[1:(which(is.na(temp))[1]-1)]}

# dim(NT_weather)

# fill rain NAs with 0
if(nrow(NT_weather[is.na(rain)]) >=1) {
  NT_weather[is.na(rain), rain := 0]
}
if(nrow(AT_weather[is.na(rain)]) >=1) {
  AT_weather[is.na(rain), rain := 0]
}
if(nrow(LX_weather[is.na(rain)]) >=1) {
  LX_weather[is.na(rain), rain := 0]
}
if(nrow(MI_weather[is.na(rain)]) >=1) {
  MI_weather[is.na(rain), rain := 0]
}
if(nrow(WA_weather[is.na(rain)]) >=1) {
  WA_weather[is.na(rain), rain := 0]
}

# # remove imp columns
# NT_weather[,c("tm_imp", "rh_imp"):= list(NULL,NULL)]
# if(all(c("tm_imp", "rh_imp") %in% colnames(AT_weather))){
# AT_weather[,c("tm_imp", "rh_imp"):= list(NULL,NULL)]}
# if(all(c("tm_imp", "rh_imp") %in% colnames(MI_weather))){
#    MI_weather[,c("tm_imp", "rh_imp"):= list(NULL,NULL)]}
# if(all(c("tm_imp", "rh_imp") %in% colnames(WA_weather))){
#    WA_weather[,c("tm_imp", "rh_imp"):= list(NULL,NULL)]}
# if(all(c("tm_imp", "rh_imp") %in% colnames(LX_weather))){
#    LX_weather[,c("tm_imp", "rh_imp"):= list(NULL,NULL)]}

# remove gatton from tamborine
NT_weather <- NT_weather[station == "PORTABLE QFRJ (North Tamborine)"]

DMod_NT <- viticolaR::estimate_DM_PI(NT_weather)
DMod_AT <- viticolaR::estimate_DM_PI(AT_weather)
DMod_MI <- viticolaR::estimate_DM_PI(MI_weather)
DMod_WA <- viticolaR::estimate_DM_PI(WA_weather)
DMod_LX <- viticolaR::estimate_DM_PI(LX_weather)

save(NT_weather, DMod_NT,
     AT_weather, DMod_AT,
     MI_weather, DMod_MI,
     LX_weather, DMod_LX,
     WA_weather, DMod_WA,
     file = "~/Weather observations/DM_dst_data.rda")
save(NT_weather, DMod_NT,
     AT_weather, DMod_AT,
     MI_weather, DMod_MI,
     LX_weather, DMod_LX,
     WA_weather, DMod_WA,
     file = "~/shiny-server/viticolR_dst/DM_dst_data.rda")
