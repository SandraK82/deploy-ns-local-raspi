__Tested with:__

- Raspberry Pi 3 (rpi3): Everything works nicely now
- Raspberry Pi 1 Model B (rpi1): Working with Raspian Jessie Lite with PIXEL (Release date: 2016-09-23)
- Raspberry Pi Zero (rpi0): Working with Raspian Jessie Lite (Release date: 2016-09-23)

__Brief:__

Use this script to setup a complete local running nightscout instance with a local mongoDB instance

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

~~I forked the current dev-branch of nightscout/cgm-remote-monitor and changed the mongodb compatibility problems. Now it runs smoothly with mongodb 2.x on a raspi!
Maybe the pull request gets accepted soon. As soon as I´m notified, I will change the script again to use the current dev-branch again.~~
The patches for mongo2.x compatibility are now merged back into the official dev branch.

2016-10-14: 

- change to nightscout 0.9.0 stable Grilled Cheese)
- add start_nightscout.sh instead of my.env

__With help from:__

https://c-ville.gitbooks.io/test/content/

http://yannickloriot.com/2016/04/install-mongodb-and-node-js-on-a-raspberry-pi/

https://www.einplatinencomputer.com/raspberry-pi-node-js-installieren/

contributions from PieterGit
