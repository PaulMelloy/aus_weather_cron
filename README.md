# aus_weather_cron  

This repo provides custom functions to download recent weather data from BOM. 

## Requirements  

A system that has `R` and `git` installed and able to be run via the `PATH`.  

### Installing R on Raspberry Pi  
I like to run this script on a raspberry pi to save weather data to test my 
weather based models.

Before installing `R` I recommend creating a shared folder on your Pi for package
libraries to be shared between users.
This is particularly helpful if running a shiny server.
Follow the instructions on my blog.  
https://paulmelloy.com.au/blog/SharedRLibrary.html  

Use the `install.sh` file to install R and setup a shared library.  


## Getting started  

Navigate to the location you wish to place this code.  

```bash
git clone https://github.com/PaulMelloy/aus_weather_cron
```

Test run the scripts
run with sudo privileges if lib is not writeable, or ensure default R package library
is writeable.  

```bash
# To resolve proper paths you need to run from the "R/" directory
cd aus_weather_cron/R
sudo Rscript run_daily_script.R
```

**NOTE:** The first time this is run it will take up to ten minutes to install the required
dependencies.  

## Update crontab

```bash
sudo crontab -e
```

To run the script daily at 3am add the following line to crontab  
```bash
0 3 * * * cd ~/R/aus_weather_cron/R/; Rscript run_daily_script.R
```