#!/bin/bash

## from https://raw.githubusercontent.com/SandraK82/deploy-ns-local-raspi/master/ns-local-install.sh

# make me current
sudo apt-get update && sudo apt-get upgrade -y

# get the right node
CPU_MODEL=$( awk '/model name/ {print $4}' < /proc/cpuinfo )
if [ "$CPU_MODEL" = "ARMv6-compatible" ]
then
  echo "ARMv6 detected"
  # install node (on ARMv6 eg. Raspberry Model A/B/B+/A+/Zero)
  wget https://nodejs.org/dist/v6.7.0/node-v6.7.0-linux-armv6l.tar.xz
  tar -xvf node-v6.7.0-linux-armv6l.tar.xz
  cd node-v6.7.0-linux-armv6l
  sudo cp -R * /usr/local/
  # check version should be v6.7.0
  node -v
  cd ..
  # clean up
  rm node-v6.7.0-linux-armv6l.tar.xz
  rm -r node-v6.7.0-linux-armv6l
else
  echo "Assuming ARMv8 (Raspi 3))"
  # install node (on ARMv8 eg Raspberry 3 Model B)
  curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
  sudo apt-get install -y nodejs
fi


# prepare npm
sudo apt-get install -y npm
sudo npm cache clean -f
sudo npm install npm -g
sudo npm install n -g

# select matching node
sudo n 4.6

# install the mongodb 2.x from apt for now
sudo apt-get install -y mongodb-server
# enable mongo
sudo systemctl enable mongodb.service
# check mongo status
sudo systemctl status mongodb.service
# get log of mongo
#cat /var/log/mongodb/mongodb.log -> should contain: [initandlisten] waiting for connections on port 27017

# go home
cd
# get ns
sudo apt-get install --assume-yes git
git clone https://github.com/nightscout/cgm-remote-monitor.git

# switching to cgm-remote-monitor directory
cd cgm-remote-monitor/
# switch to dev
git checkout dev

# setup ns
./setup.sh

# put your config into it
curl -o my.env https://raw.githubusercontent.com/SandraK82/deploy-ns-local-raspi/master/my.env

# make autoboot
cd
curl -o nightscout https://raw.githubusercontent.com/SandraK82/deploy-ns-local-raspi/master/nightscout
sudo mv nightscout /etc/init.d/nightscout
sudo chmod +x /etc/init.d/nightscout
sudo /etc/init.d/nightscout start
sudo /etc/init.d/nightscout status
sudo insserv -d nightscout

echo "deploy nightscout on raspi done :)"
echo "Dont forget to edit: /home/pi/cgm-remote-monitor/my.env"
