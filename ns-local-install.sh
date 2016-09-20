#!/bin/bash

# make me current
sudo apt-get update && sudo apt-get upgrade -y 

# get the right node
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -

# install node
sudo apt-get install -y nodejs 

# prekäre npm
sudo apt-get install npm
sudo npm cache clean -f
sudo npm install npm -g
sudo npm install n -g

# select matching node
sudo n 4.5

# install the mongodb
sudo apt-get install mongodb-server
# enable mongo
sudo systemctl enable mongodb.service
# check mongo status
sudo systemctl mongodb.service status
sudo systemctl status mongodb.service
# get log of mongo
#cat /var/log/mongodb/mongodb.log -> should contain: [initandlisten] waiting for connections on port 27017

# go home
cd
# get ns
git clone https://github.com/nightscout/cgm-remote-monitor.git
cd cgm-remote-monitor/
# switch to dev
git checkout dev

# setup ns
./setup.sh 

# put your config into it
nano my.cfg

# make autoboot
sudo nano /etc/init.d/nightscout
sudo chmod +x /etc/init.d/nightscout
sudo /etc/init.d/nightscout start
sudo /etc/init.d/nightscout status
sudo update-rc.d nightscout defaults