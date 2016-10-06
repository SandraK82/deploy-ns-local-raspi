__Tested with:__

- Raspberry Pi 3: Everything works nicely now
- Raspberry Pi Model B: Working with Raspian Jessie Lite

__Brief:__

Use this script to setup a complete local running nightscout instance with a local mongoDB instance

__Usage:__

`curl -s https://raw.githubusercontent.com/SandraK82/deploy-ns-local-raspi/master/ns-local-install.sh | bash -`

after running the script you will have a running nightscout local installation and an open editor with your config for nightscout. You need to configure at least the lines at tht top of the file:
`CUSTOM_TITLE=mysitename_without_spaces`
`API_SECRET=my_12_character_passwort`

Put your personal password (at least 12 characters long) and teh name of your site (just for Display) there!
Please note that you _CAN_NOT_ have any spaces in your configuration. To separate values use %20 instead. For the CUSTOM_TITLE Parameter this does not work!

__Updates:__

~~I forked the current dev-branch of nightscout/cgm-remote-monitor and changed the mongodb compatibility problems. Now it runs smoothly with mongodb 2.x on a raspi!
Maybe the pull request gets accepted soon. As soon as I´m notified, I will change the script again to use the current dev-branch again.~~
The patches for mongo2.x compatibility are now merged back into the official deb branch.

__With help from:__

https://c-ville.gitbooks.io/test/content/

http://yannickloriot.com/2016/04/install-mongodb-and-node-js-on-a-raspberry-pi/
