# aus_weather_cron  

This repo provides custom functions to download recent weather data from BOM. 

## Requirements  

A system that has `R` and `git` installed and able to be run via the `PATH`.  

## Getting started  

Navigate to the location you wish to place this code.  

```bash
git clone https://github.com/PaulMelloy/aus_weather_cron
```

Test run the scripts
run with sudo privileges if lib is not writable, or ensure default R package library
is writable.  

```bash
cd aus_weather_cron
sudo Rscript R/run_daily_script.R
```