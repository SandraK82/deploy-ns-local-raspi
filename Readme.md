__Brief:__

Use this script to setup a complete local running Nightscout instance. This script can either install:
- a local MongoDB instance or
- work without MongoDB and use static OpenAPS report files (recommended for tiny rigs) 

__Tested with:__

- Raspberry Pi Zero (rpi0): Working with Raspian Jessie Lite (Release date: 2016-09-23)
- Raspberry Pi 1 Model B (rpi1): Working with Raspian Jessie Lite with PIXEL (Release date: 2016-09-23)
- Raspberry Pi 3 (rpi3): Everything works nicely with or without PIXEL

__Prerequisites__

0. Install Raspberry Pi SD kart with Rasbian. Download Raspbian at https://www.raspberrypi.org/downloads/raspbian/
	You can you choose to use:
	- Rasbian Jessie with PIXEL: This has a graphical user interface, called PIXEL desktop
	- Raspbian Jessie Lite: A minimal image based on Debian Jessie. No desktop included.

1. Make sure your Raspberry kernel is up to date 
   `$ sudo apt-get install rpi-update && sudo rpi-update `
   and reboot.

2. Configure your Rasberry Pi
   `$ sudo raspi-config`
```   
1. Expand Filesystem   ==> Make use of the whole SD-CARD
2. Change User Password     	
3. Bootoptions ==> Choose what you want
4. Wait for Network at Boot ==> Set to No
5.  Internationalisation Options => Change Locale, Timezone, Keyboard Layout, Wi-Fi country to your needs
A2. Hostname ==> Set your hostname. This will be used for the URL of your Nightscout 
A4. SSH ==> Enable SSH for remote access
```

__Usage:__

 1. open console on your raspi eg `ssh pi@192.168.10.4` default-password `raspberry` and run ns-local-install script:
    `curl -s https://raw.githubusercontent.com/SandraK82/deploy-ns-local-raspi/master/ns-local-install.sh | bash -`
    relax and drink some :coffee: - script runtime *over 1.5 hour* on clean and fresh raspi.
 2. after running the script you will have a running nightscout local installation. Now open editor with your config for nightscout.
    `nano /home/pi/cgm-remote-monitor/start-nightscout.sh`
     You need to configure at least the lines at the top of the file:
    `CUSTOM_TITLE=mysitename_without_spaces`
    `API_SECRET=my_12_characters_or_more_password``
	
    Put your personal password (at least 12 characters long) and the name of your site (just for display) there!
 
 3. once finished, restart nightscout with: `sudo /etc/init.d/nightscout stop && sudo /etc/init.d/nightscout start`
 4. navigate to http://192.168.10.4:1337/ complete nightscout profile settings
 5. Have fun :smiley:

__Troubleshooting:__

 * nodejs manual start: `pi@raspberrypi:~/cgm-remote-monitor $ start-nightscout.sh` (must be in cgm-remote-monitor directory)
 * nodejs / nightscout log: check `cat /var/log/openaps/nightscout.log` 
 * mongodb check `cat /var/log/mongodb/mongodb.log` should contain: `[initandlisten] waiting for connections on port 27017`

__Changelog:__

2016-11-13:

- upgrade nightscout to 0.9.1-dev-20161112, in order to support openaps-storage, see https://github.com/nightscout/cgm-remote-monitor/pull/2114

2016-10-14: 

- change to nightscout 0.9.0 stable ()Grilled Cheese)
- add start_nightscout.sh instead of my.env

2016-09:
~~I forked the current dev-branch of nightscout/cgm-remote-monitor and changed the mongodb compatibility problems. Now it runs smoothly with mongodb 2.x on a raspi!
Maybe the pull request gets accepted soon. As soon as I´m notified, I will change the script again to use the current dev-branch again.~~
The patches for mongo2.x compatibility are now merged back into the official dev branch.

__With help from:__

- https://c-ville.gitbooks.io/test/content/
- http://yannickloriot.com/2016/04/install-mongodb-and-node-js-on-a-raspberry-pi/
- https://www.einplatinencomputer.com/raspberry-pi-node-js-installieren/
- contributions from PieterGit

__Whishlist/To Do:__
- seperate username/password for Mongo
- Nginx to use for https / letsencrypt certificate
- Script to create wifi hotspot on the raspberry pi
- Always install latest Node (now 6.8.0 instead of 6.7.0 what is being installed)
- ...