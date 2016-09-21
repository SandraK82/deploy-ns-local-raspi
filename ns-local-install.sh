#!/bin/bash

## from https://raw.githubusercontent.com/SandraK82/deploy-ns-local-raspi/master/ns-local-install.sh

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

###not working!
##build system für mongodb
#sudo apt-get install build-essential libssl-dev git scons libboost-filesystem-dev libboost-program-options-dev libboost-system-dev libboost-thread-dev
#
#git clone git://github.com/mongodb/mongo.git
#cd mongo
#git checkout r3.0.12
#
##patch a file
#
#curl -o src/third_party/v8-3.25/SConscript https://gist.githubusercontent.com/kitsook/f0f53bc7acc468b6e94c/raw/93ebc8dc0adf7afb0a38c1b6bf702f8a8c6b70c2/SConscript
#
##compile
#scons -j 2 --ssl --wiredtiger=off --js-engine=v8-3.25 --c++11=on --opt=off --disable-warnings-as-errors --use-system-boost CXXFLAGS="-std=gnu++11" core
###

# install the mongodb 2.x from apt for now
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
#nano my.env
curl -o my.env https://raw.githubusercontent.com/SandraK82/deploy-ns-local-raspi/master/my.env

# make autoboot
#sudo nano /etc/init.d/nightscout
cd
curl -o nightscout https://raw.githubusercontent.com/SandraK82/deploy-ns-local-raspi/master/nightscout
sudo mv nightscout /etc/init.d/nightscout
sudo chmod +x /etc/init.d/nightscout
sudo /etc/init.d/nightscout start
sudo /etc/init.d/nightscout status
sudo update-rc.d nightscout defaults

nano /home/pi/cgm-remote-monitor/my.env
