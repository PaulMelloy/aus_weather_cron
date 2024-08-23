download_state_weather <- function(download_path,
                                   download_time,
                                   sleep_delays = TRUE){
  
  if(SLEEP) {
    Sys.sleep(round(runif(1, 0, 240))) # wait randomly between 0 amd 4 minutes
  }
  get_bom_observations(ftp_url = "ftp://ftp.bom.gov.au/anon/gen/fwo/",
                       download_location = dl_path,
                       access_warning = FALSE,
                       state = "QLD",
                       file_prefix = dl_time
  )
  
  if(SLEEP) {
    Sys.sleep(round(runif(1, 0, 240))) # wait randomly between 0 amd 4 minutes
  }
  
  get_bom_observations(ftp_url = "ftp://ftp.bom.gov.au/anon/gen/fwo/",
                       download_location = dl_path,
                       access_warning = FALSE,
                       state = "NSW",
                       file_prefix = dl_time
  )
  if(SLEEP) {
    Sys.sleep(round(runif(1, 0, 240))) # wait randomly between 0 amd 4 minutes
  }
  get_bom_observations(ftp_url = "ftp://ftp.bom.gov.au/anon/gen/fwo/",
                       download_location = dl_path,
                       access_warning = FALSE,
                       file_prefix = dl_time,
                       state = "NT"
  )
  if(SLEEP) {
    Sys.sleep(round(runif(1, 0, 240))) # wait randomly between 0 amd 4 minutes
  }
  get_bom_observations(ftp_url = "ftp://ftp.bom.gov.au/anon/gen/fwo/",
                       download_location = dl_path,
                       access_warning = FALSE,
                       state = "SA",
                       file_prefix = dl_time
  )
  if(SLEEP) {
    Sys.sleep(round(runif(1, 0, 240))) # wait randomly between 0 amd 4 minutes
  }
  get_bom_observations(ftp_url = "ftp://ftp.bom.gov.au/anon/gen/fwo/",
                       download_location = dl_path,
                       access_warning = FALSE,
                       file_prefix = dl_time,
                       state = "VIC"
  )
  if(SLEEP) {
    Sys.sleep(round(runif(1, 0, 240))) # wait randomly between 0 amd 4 minutes
  }
  get_bom_observations(ftp_url = "ftp://ftp.bom.gov.au/anon/gen/fwo/",
                       download_location = dl_path,
                       access_warning = FALSE,
                       file_prefix = dl_time,
                       state = "WA"
  )
  if(SLEEP) {
    Sys.sleep(round(runif(1, 0, 240))) # wait randomly between 0 amd 4 minutes
  }
  get_bom_observations(ftp_url = "ftp://ftp.bom.gov.au/anon/gen/fwo/",
                       download_location = dl_path,
                       access_warning = FALSE,
                       state = "TAS",
                       file_prefix = dl_time
  )
  
  
}