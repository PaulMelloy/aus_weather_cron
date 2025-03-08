#!/bin/bash
sudo apt update
sudo apt upgrade -y
# install R
sudo apt install r-base r-base-dev -y
# Install dependancies
sudo apt install libudunits2-dev libssl-dev libgdal-dev -y