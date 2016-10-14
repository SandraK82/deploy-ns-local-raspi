#!/bin/bash

## from https://raw.githubusercontent.com/SandraK82/deploy-ns-local-raspi/master/ns-local-install.sh

## TODO: set /etc/domainname

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


# install dependencies 
# get git, mongodb 2.x from apt for now,and npm
# optional extra packages to easily debug stuff or to do better maintenance
EXTRAS="etckeeper tcsh lsof"
sudo apt-get install --assume-yes git mongodb-server npm $EXTRAS

sudo npm cache clean -f
sudo npm install npm -g
sudo npm install n -g

# select matching node
sudo n 4.6

# enable mongo
sudo systemctl enable mongodb.service
# check mongo status
sudo systemctl status mongodb.service
# get log of mongo
#cat /var/log/mongodb/mongodb.log -> should contain: [initandlisten] waiting for connections on port 27017

# go home
cd

# get start script
while true; do
    read -p "Do you want to use mmol or mg? " unit
    case $uni in
        mmol) curl -o start_nightscout.sh https://raw.githubusercontent.com/SandraK82/deploy-ns-local-raspi/master/start_nightscout.sh; break;;
        mg) curl -o start_nightscout.sh https://raw.githubusercontent.com/SandraK82/deploy-ns-local-raspi/master/start_nightscout-mg.sh; break;;
        * ) echo "Please answer mmol or mg.";;
esac
done

chmod +rx start_nightscout.sh

git clone https://github.com/nightscout/cgm-remote-monitor.git

# switching to cgm-remote-monitor directory
cd cgm-remote-monitor/
# switch to master (latest stable version)
git checkout master

# setup ns
./setup.sh


# make autoboot
cd
curl -o nightscout https://raw.githubusercontent.com/SandraK82/deploy-ns-local-raspi/master/nightscout
sudo mv nightscout /etc/init.d/nightscout
sudo chmod +x /etc/init.d/nightscout
sudo /etc/init.d/nightscout start
sudo /etc/init.d/nightscout status
sudo insserv -d nightscout

echo "deploy nightscout on raspi done :)"
echo "Dont forget to edit: /home/pi/cgm-remote-monitor/start_nightscout.sh"
echo "Nightscout logging can be found at: /var/log/openaps/nightscout.log"

# Setup basis oref0 stuff
# https://openaps.readthedocs.io/en/dev/docs/walkthrough/phase-2/oref0-setup.html
curl -s https://raw.githubusercontent.com/openaps/docs/master/scripts/quick-packages.sh | bash -

mkdir -p ~/src; cd ~/src && git clone -b dev git://github.com/openaps/oref0.git || (cd oref0 && git checkout dev && git pull)


echo "Please continue with step 2 of https://openaps.readthedocs.io/en/dev/docs/walkthrough/phase-2/oref0-setup.html"
echo "cd && ~/src/oref0/bin/oref0-setup.sh"
